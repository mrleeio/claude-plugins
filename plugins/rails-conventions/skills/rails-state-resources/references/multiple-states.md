# Multiple States Pattern

Handle mutually exclusive states using multiple join tables.

## Example: Card States

A card can be in one of several states: triage, active, closed, or postponed.

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  has_one :closure
  has_one :not_now  # postponed state

  # State scopes
  scope :in_triage, -> { where(column: nil).where.missing(:closure, :not_now) }
  scope :active, -> { where.not(column: nil).where.missing(:closure, :not_now) }
  scope :closed, -> { joins(:closure) }
  scope :postponed, -> { joins(:not_now) }

  def status
    if closure.present?
      :closed
    elsif not_now.present?
      :postponed
    elsif column.present?
      :active
    else
      :triage
    end
  end
end
```

## State Transition Rules

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  def close(user: Current.user)
    transaction do
      not_now&.destroy  # Clear postponed if set
      create_closure!(user: user) unless closed?
      track_event :closed, creator: user
    end
  end

  def postpone(user: Current.user)
    transaction do
      closure&.destroy  # Clear closed if set
      create_not_now!(user: user) unless postponed?
      track_event :postponed, creator: user
    end
  end

  def activate(user: Current.user)
    transaction do
      closure&.destroy
      not_now&.destroy
      track_event :activated, creator: user
    end
  end
end
```

## Combining with `where.missing`

Rails 6.1+ supports `where.missing` for left outer join conditions:

```ruby
# Cards that are NOT closed AND NOT postponed
Card.where.missing(:closure, :not_now)

# Cards with column assigned but not in terminal states
Card.where.not(column: nil).where.missing(:closure, :not_now)
```

## State Machine Alternative

For complex state machines, consider if sub-resources are still appropriate:

| Complexity | Recommendation |
|------------|----------------|
| 2-3 boolean states | Sub-resources work well |
| 4+ mutually exclusive states | Consider state column or gem |
| Complex transitions | State machine gem (AASM, Statesman) |
| Simple on/off toggles | Sub-resources are ideal |

## Join Table Structure

Each state gets its own table:

```ruby
# db/migrate/XXX_create_closures.rb
create_table :closures do |t|
  t.references :card, null: false, foreign_key: true, index: { unique: true }
  t.references :user, null: false, foreign_key: true
  t.timestamps
end

# db/migrate/XXX_create_not_nows.rb
create_table :not_nows do |t|
  t.references :card, null: false, foreign_key: true, index: { unique: true }
  t.references :user, null: false, foreign_key: true
  t.datetime :until  # Optional: scheduled reactivation
  t.timestamps
end
```
