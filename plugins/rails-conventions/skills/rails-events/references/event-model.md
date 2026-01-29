# Event Model

The core event model with polymorphic associations and JSON particulars.

## Model Definition

```ruby
# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :account
  belongs_to :creator, class_name: "User", default: -> { Current.user }
  belongs_to :eventable, polymorphic: true

  # JSON column for action-specific data
  serialize :particulars, coder: JSON

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

## Schema Design

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

## Key Fields

| Field | Purpose |
|-------|---------|
| `eventable` | Polymorphic reference to what the event is about |
| `action` | Verb describing what happened (moved, closed, assigned) |
| `particulars` | JSON hash with action-specific context |
| `creator` | Who triggered the event (defaults to Current.user) |

## Using Particulars

Store context needed to reconstruct what happened:

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
  assignee_name: assignee.name  # Denormalize for historical accuracy

# Changing a field
track_event :updated,
  field: "title",
  old_value: title_was,
  new_value: title
```

## Best Practices

1. **Track domain events** - Use verbs like `closed`, `assigned`, `moved`, not `updated`
2. **Include context** - Store IDs and denormalized data for historical accuracy
3. **Use explicit methods** - Call `track_event` in model methods, not callbacks
4. **Async side effects** - Dispatch webhooks and notifications in background jobs
