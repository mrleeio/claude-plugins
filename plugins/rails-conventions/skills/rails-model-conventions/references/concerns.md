# Rich Domain Models with Composable Concerns

Structure complex models by extracting cohesive behaviors into concerns. This keeps models readable while enabling rich domain logic.

## Directory Structure

Organize concerns alongside their model in a dedicated directory:

```
app/models/
├── card.rb
├── card/
│   ├── assignable.rb
│   ├── closeable.rb
│   ├── postponable.rb
│   └── watchable.rb
├── board.rb
└── board/
    ├── accessible.rb
    └── publishable.rb
```

## Concern Structure Pattern

Each concern follows a consistent structure:

1. **Associations** at the top
2. **Scopes** next
3. **Query methods** (predicate methods)
4. **Action methods** last

```ruby
# app/models/card/closeable.rb
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    # 1. Associations
    has_one :closure, dependent: :destroy

    # 2. Scopes
    scope :closed, -> { joins(:closure) }
    scope :open, -> { where.missing(:closure) }
    scope :recently_closed_first, -> { closed.order(closures: { created_at: :desc }) }
    scope :closed_by, ->(users) { closed.where(closures: { user_id: Array(users) }) }
  end

  # 3. Query methods
  def closed?
    closure.present?
  end

  def open?
    !closed?
  end

  def closed_by
    closure&.user
  end

  def closed_at
    closure&.created_at
  end

  # 4. Action methods
  def close(user: Current.user)
    unless closed?
      transaction do
        create_closure!(user: user)
        track_event :closed, creator: user
      end
    end
  end

  def reopen(user: Current.user)
    if closed?
      transaction do
        closure.destroy
        track_event :reopened, creator: user
      end
    end
  end
end
```

## Main Model File

The main model file includes concerns and contains only model-wide configuration:

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  include Eventable
  include Card::Assignable
  include Card::Closeable
  include Card::Postponable
  include Card::Watchable

  belongs_to :account
  belongs_to :board
  belongs_to :column
  belongs_to :creator, class_name: "User", default: -> { Current.user }

  has_rich_text :description

  validates :title, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
```

## Example: Assignable Concern

```ruby
# app/models/card/assignable.rb
module Card::Assignable
  extend ActiveSupport::Concern

  included do
    has_many :assignments, dependent: :destroy
    has_many :assignees, through: :assignments, source: :user
  end

  def assigned?
    assignees.any?
  end

  def assigned_to?(user)
    assignees.include?(user)
  end

  def assign(user, assigner: Current.user)
    unless assigned_to?(user)
      transaction do
        assignments.create!(user: user)
        track_event :assigned, creator: assigner, assignee_id: user.id
      end
    end
  end

  def unassign(user, unassigner: Current.user)
    if assigned_to?(user)
      transaction do
        assignments.find_by(user: user)&.destroy
        track_event :unassigned, creator: unassigner, assignee_id: user.id
      end
    end
  end
end
```

## Example: Watchable Concern

```ruby
# app/models/card/watchable.rb
module Card::Watchable
  extend ActiveSupport::Concern

  included do
    has_many :watches, dependent: :destroy
    has_many :watchers, through: :watches, source: :user
  end

  def watched_by?(user)
    watchers.include?(user)
  end

  def watch(user: Current.user)
    watches.find_or_create_by!(user: user) unless watched_by?(user)
  end

  def unwatch(user: Current.user)
    watches.find_by(user: user)&.destroy
  end

  def watchers_to_notify
    watchers.where.not(id: Current.user)
  end
end
```

## Integration with Event Tracking

Concerns should use `track_event` from the `Eventable` concern:

```ruby
module Card::Postponable
  extend ActiveSupport::Concern

  included do
    has_one :not_now, dependent: :destroy
    scope :postponed, -> { joins(:not_now) }
    scope :active, -> { where.missing(:not_now) }
  end

  def postponed?
    not_now.present?
  end

  def postpone(user: Current.user)
    unless postponed?
      transaction do
        create_not_now!(user: user)
        track_event :postponed, creator: user
      end
    end
  end

  def restore(user: Current.user)
    if postponed?
      transaction do
        not_now.destroy
        track_event :restored, creator: user
      end
    end
  end
end
```

## When to Extract a Concern

Extract a concern when you have:

1. **Cohesive behavior**: Related associations, scopes, and methods that form a logical unit
2. **State transitions**: Open/closed, published/draft, active/archived patterns
3. **Relationships with side effects**: Assignments, watches, follows that trigger events
4. **Reusable patterns**: Behavior that might apply to multiple models

## Best Practices

1. **One responsibility per concern**: Each concern handles one aspect of behavior
2. **Consistent naming**: Use adjectives (`Closeable`, `Assignable`) or nouns (`Closure`, `Assignment`)
3. **Depend on Eventable**: Action methods should track events when state changes
4. **Use transactions**: Wrap state changes and event tracking in transactions
5. **Default to Current.user**: Action methods should default the actor to `Current.user`
