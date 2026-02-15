---
name: rails-events
description: Use when implementing event tracking, activity logs, or webhooks. Covers polymorphic events and audit trail patterns.
---

# Event-Driven Architecture Pattern

Track significant actions in your application using a polymorphic `Event` model. Events drive activity timelines, notifications, webhooks, and audit trails.

## Quick Reference

| Do | Don't |
|----|-------|
| Track domain events (`closed`, `assigned`, `moved`) | Track generic CRUD (`updated`, `saved`) |
| Store context in `particulars` JSON column | Rely on current state for historical data |
| Use `after_create_commit` for async side effects | Trigger side effects synchronously |
| Dispatch webhooks and notifications in background jobs | Send webhooks inline during request |
| Track events in explicit model methods | Track events in `after_save` callbacks |
| Scope events to account for multi-tenant isolation | Create global events without account scoping |
| Include `Eventable` concern for consistent interface | Duplicate event tracking logic per model |

## Event Model

```ruby
# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :account
  belongs_to :creator, class_name: "User", default: -> { Current.user }
  belongs_to :eventable, polymorphic: true

  # JSON column for action-specific data
  # e.g., { "old_column_id" => "abc", "new_column_id" => "xyz" }
  serialize :particulars, coder: JSON

  # Callbacks for side effects
  after_create_commit :relay_later
  after_create_commit :notify_later

  scope :recent, -> { order(created_at: :desc) }
  scope :for_eventable, ->(eventable) { where(eventable: eventable) }

  private
    def relay_later
      Event::RelayJob.perform_later(self)
    end

    def notify_later
      Event::NotifyJob.perform_later(self)
    end
end
```

## Migration

```ruby
class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :creator, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.references :eventable, polymorphic: true, null: false, type: :uuid
      t.string :action, null: false
      t.json :particulars, default: {}
      t.timestamps
    end

    add_index :events, [:eventable_type, :eventable_id, :created_at]
    add_index :events, [:account_id, :created_at]
  end
end
```

## Eventable Concern

Include this concern in any model that should track events:

```ruby
# app/models/concerns/eventable.rb
module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable, dependent: :destroy
  end

  def track_event(action, creator: Current.user, **particulars)
    events.create!(
      account: account,
      creator: creator,
      action: action,
      particulars: particulars
    )
  end
end
```

## Using Events in Models

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  include Eventable

  belongs_to :account
  belongs_to :column

  def move_to(new_column, user: Current.user)
    old_column = column

    transaction do
      update!(column: new_column)
      track_event :moved, creator: user,
        old_column_id: old_column.id,
        new_column_id: new_column.id
    end
  end

  def close(user: Current.user)
    transaction do
      update!(closed_at: Time.current)
      track_event :closed, creator: user
    end
  end
end
```

## Webhook Dispatch

```ruby
# app/models/event/relaying.rb
module Event::Relaying
  extend ActiveSupport::Concern

  def relay_now
    account.webhooks.active.each do |webhook|
      webhook.deliver(payload)
    end
  end

  private
    def payload
      {
        event: action,
        eventable_type: eventable_type,
        eventable_id: eventable_id,
        creator_id: creator_id,
        particulars: particulars,
        created_at: created_at.iso8601
      }
    end
end

# app/jobs/event/relay_job.rb
class Event::RelayJob < ApplicationJob
  def perform(event)
    event.relay_now
  end
end
```

## Activity Timeline

```ruby
# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  def show
    @card = Card.find(params[:id])
    @events = @card.events.recent.includes(:creator)
  end
end
```

```erb
<%# app/views/cards/_events.html.erb %>
<% events.each do |event| %>
  <div class="event">
    <span class="creator"><%= event.creator.name %></span>
    <span class="action"><%= event.action %></span>
    <span class="time"><%= time_ago_in_words(event.created_at) %> ago</span>
  </div>
<% end %>
```

## Event-Specific Data with Particulars

The `particulars` JSON column stores action-specific context:

```ruby
# Moving a card
track_event :moved,
  old_column_id: old_column.id,
  new_column_id: new_column.id,
  old_position: old_position,
  new_position: new_position

# Assigning a user
track_event :assigned,
  assignee_id: assignee.id,
  assignee_name: assignee.name

# Changing a field
track_event :updated,
  field: "title",
  old_value: title_was,
  new_value: title
```

## Common Mistakes

1. **Tracking CRUD instead of domain events**: Events like `updated` or `saved` are noise. Track meaningful actions like `closed`, `assigned`, `moved` that users care about
2. **Not storing context in particulars**: Relying on current state means historical events become meaningless when data changes. Always store old/new values in `particulars`
3. **Synchronous side effects**: Webhook delivery and notification creation should happen in background jobs via `after_create_commit`, not synchronously during the request
4. **Tracking events in `after_save` callbacks**: This creates events for every save, including internal updates. Track events explicitly in domain methods like `close` and `move_to`
5. **Missing account scoping**: In multi-tenant apps, events without `account_id` can leak across tenants. Always scope events to an account
6. **Not using transactions**: Event creation and the state change it records should be in the same transaction. If the event fails, the state change should roll back
7. **Forgetting to include creator**: Events without a creator lose attribution. Use `default: -> { Current.user }` on the `creator` association

## Best Practices

1. **Track domain events, not CRUD**: Track `closed`, `assigned`, `moved` - not `updated`
2. **Include context in particulars**: Store IDs and denormalized data for historical accuracy
3. **Use callbacks sparingly**: Track events in explicit methods, not in `after_save`
4. **Async side effects**: Dispatch webhooks and notifications in background jobs
5. **Scope to account**: Events belong to accounts for multi-tenant isolation

## See Also

- [Event Model](references/event-model.md) - Core model with JSON particulars
- [Webhook Dispatch](references/webhook-dispatch.md) - Relay pattern and delivery
- [Eventable Concern](references/eventable-concern.md) - Concern for tracking events
