# Notification Model

The core notification model with read state tracking, polymorphic source, and bundling support.

## Model Definition

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

## Schema Design

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

## Key Fields

| Field | Purpose |
|-------|---------|
| `source` | Polymorphic reference to what triggered the notification (Event, Mention, etc.) |
| `creator` | Who caused the notification (excludes them from receiving it) |
| `read_at` | Tracks whether user has seen/dismissed the notification |
| `bundled_at` | Marks notifications included in a digest email |

## Query Patterns

```ruby
# Unread notifications for a user
Current.user.notifications.unread.recent

# Notifications for digest emails
user.notifications.unbundled.recent

# Mark as read
notification.read!

# Bulk mark as read
Current.user.notifications.unread.update_all(read_at: Time.current)
```
