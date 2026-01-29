---
name: rails-notifications
description: Use when implementing user notifications, mentions, or email alerts. Covers polymorphic notification patterns and delivery options.
---

# Polymorphic Notification System

Build a flexible notification system that handles different source types (events, mentions, etc.) with a factory pattern for determining recipients.

## Core Models

### Notification Model

```ruby
# app/models/notification.rb
class Notification < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :source, polymorphic: true
  belongs_to :creator, class_name: "User"

  scope :unread, -> { where(read_at: nil) }
  scope :recent, -> { order(created_at: :desc) }
  scope :unbundled, -> { where(bundled_at: nil) }

  after_create_commit :deliver_later

  def read!
    update!(read_at: Time.current) unless read?
  end

  def read?
    read_at.present?
  end

  private
    def deliver_later
      Notification::DeliverJob.perform_later(self)
    end
end
```

### Migration

```ruby
class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :creator, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :source, polymorphic: true, null: false, type: :uuid
      t.datetime :read_at
      t.datetime :bundled_at
      t.timestamps
    end

    add_index :notifications, [:user_id, :read_at]
    add_index :notifications, [:user_id, :created_at]
  end
end
```

## Notifiable Concern

Include in models that trigger notifications:

```ruby
# app/models/concerns/notifiable.rb
module Notifiable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :source, dependent: :destroy
    after_create_commit :notify_later
  end

  def notify_later
    Notifiable::NotifyJob.perform_later(self)
  end

  def notify_now
    Notifier.for(self)&.notify
  end
end
```

### Apply to Models

```ruby
# app/models/event.rb
class Event < ApplicationRecord
  include Notifiable
  # ...
end

# app/models/mention.rb
class Mention < ApplicationRecord
  include Notifiable
  # ...
end
```

## Notifier Factory Pattern

The `Notifier` class routes to the appropriate notifier based on source type:

```ruby
# app/models/notifier.rb
class Notifier
  attr_reader :source

  class << self
    def for(source)
      case source
      when Event
        notifier_for_event(source)
      when Mention
        MentionNotifier.new(source)
      end
    end

    private
      def notifier_for_event(event)
        # Route to event-type-specific notifier
        "Notifier::#{event.eventable.class}EventNotifier".safe_constantize&.new(event)
      end
  end

  def notify
    if should_notify?
      recipients.sort_by(&:id).each do |recipient|
        Notification.create!(
          account: source.account,
          user: recipient,
          source: source,
          creator: creator
        )
      end
    end
  end

  private
    def initialize(source)
      @source = source
    end

    def should_notify?
      !creator.system?
    end

    def creator
      raise NotImplementedError
    end

    def recipients
      raise NotImplementedError
    end
end
```

## Specific Notifiers

### Card Event Notifier

```ruby
# app/models/notifier/card_event_notifier.rb
class Notifier::CardEventNotifier < Notifier
  private
    def creator
      source.creator
    end

    def recipients
      source.eventable.watchers.where.not(id: creator)
    end

    def should_notify?
      super && source.action.in?(%w[closed reopened assigned moved])
    end
end
```

### Comment Event Notifier

```ruby
# app/models/notifier/comment_event_notifier.rb
class Notifier::CommentEventNotifier < Notifier
  private
    def creator
      source.creator
    end

    def recipients
      card.watchers.where.not(id: creator)
    end

    def card
      source.eventable.card
    end
end
```

### Mention Notifier

```ruby
# app/models/notifier/mention_notifier.rb
class Notifier::MentionNotifier < Notifier
  private
    def creator
      source.mentioner
    end

    def recipients
      [source.mentioned_user].compact - [creator]
    end
end
```

## Notification Delivery

### Immediate Delivery

```ruby
# app/jobs/notification/deliver_job.rb
class Notification::DeliverJob < ApplicationJob
  def perform(notification)
    return if notification.user.notifications_paused?

    NotificationMailer.notification(notification).deliver_now
  end
end
```

### Bundled Delivery (Digest)

For users who prefer bundled notifications:

```ruby
# app/jobs/notifications/deliver_bundled_job.rb
class Notifications::DeliverBundledJob < ApplicationJob
  def perform
    User.wants_bundled_notifications.find_each do |user|
      notifications = user.notifications.unbundled.recent

      if notifications.any?
        NotificationMailer.bundled(user, notifications).deliver_now
        notifications.update_all(bundled_at: Time.current)
      end
    end
  end
end
```

Schedule in `config/recurring.yml`:

```yaml
production:
  deliver_bundled_notifications:
    class: Notifications::DeliverBundledJob
    schedule: every 30 minutes
```

## Controller

```ruby
# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController
  def index
    @notifications = Current.user.notifications.recent.includes(:source, :creator)
  end

  def update
    @notification = Current.user.notifications.find(params[:id])
    @notification.read!

    respond_to do |format|
      format.html { redirect_to @notification.source }
      format.turbo_stream
    end
  end

  def read_all
    Current.user.notifications.unread.update_all(read_at: Time.current)
    redirect_to notifications_path
  end
end
```

## Views

```erb
<%# app/views/notifications/index.html.erb %>
<% @notifications.each do |notification| %>
  <%= render partial: "notifications/#{notification.source_type.underscore}",
             locals: { notification: notification } %>
<% end %>

<%# app/views/notifications/_event.html.erb %>
<div class="notification <%= 'unread' unless notification.read? %>">
  <%= link_to notification.source.eventable do %>
    <strong><%= notification.creator.name %></strong>
    <%= notification.source.action %>
    <strong><%= notification.source.eventable.title %></strong>
  <% end %>
  <span class="time"><%= time_ago_in_words(notification.created_at) %> ago</span>
</div>
```

## Best Practices

1. **Factory pattern**: Route to specific notifiers based on source type
2. **Async creation**: Use `after_create_commit` to trigger notification jobs
3. **Exclude creator**: Never notify the person who triggered the action
4. **Skip system users**: Don't notify for automated actions
5. **Bundling support**: Allow users to receive digest emails instead of immediate
6. **Polymorphic source**: Notifications can come from events, mentions, or other sources
7. **Deterministic ordering**: Sort recipients by ID to avoid deadlocks

## See Also

- [Notification Model](references/notification-model.md) - Core model with read state and bundling
- [Factory Pattern](references/factory-pattern.md) - Routing to type-specific notifiers
- [Specific Notifiers](references/specific-notifiers.md) - Implementation examples
- [Delivery Strategies](references/delivery-strategies.md) - Immediate vs bundled delivery
