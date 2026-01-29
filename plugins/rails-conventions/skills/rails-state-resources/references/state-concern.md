# State Concern Pattern

Extract state logic into concerns with scopes, predicates, and transition methods.

## Closeable Concern Example

```ruby
# app/models/card/closeable.rb
module Card::Closeable
  extend ActiveSupport::Concern

  included do
    has_one :closure, dependent: :destroy

    scope :closed, -> { joins(:closure) }
    scope :open, -> { where.missing(:closure) }
  end

  def closed?
    closure.present?
  end

  def open?
    !closed?
  end

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

## Join Model

```ruby
# app/models/closure.rb
class Closure < ApplicationRecord
  belongs_to :card
  belongs_to :user, default: -> { Current.user }
end
```

## Concern Structure

| Component | Purpose |
|-----------|---------|
| `has_one :state_record` | Association to join model |
| `scope :in_state` | Query records in this state |
| `scope :not_in_state` | Query records not in this state |
| `state?` predicate | Check if record is in state |
| `enter_state` method | Transition into state |
| `exit_state` method | Transition out of state |

## Generic Template

```ruby
# app/models/MODEL/STATEABLE.rb
module MODEL::STATEABLE
  extend ActiveSupport::Concern

  included do
    has_one :STATE_RECORD, dependent: :destroy

    scope :STATE_NAME, -> { joins(:STATE_RECORD) }
    scope :NOT_STATE_NAME, -> { where.missing(:STATE_RECORD) }
  end

  def STATE_NAME?
    STATE_RECORD.present?
  end

  def ENTER_STATE(user: Current.user)
    unless STATE_NAME?
      transaction do
        create_STATE_RECORD!(user: user)
        track_event :ENTERED_STATE, creator: user
      end
    end
  end

  def EXIT_STATE(user: Current.user)
    if STATE_NAME?
      transaction do
        STATE_RECORD.destroy
        track_event :EXITED_STATE, creator: user
      end
    end
  end
end
```

## Including in Models

```ruby
# app/models/card.rb
class Card < ApplicationRecord
  include Card::Closeable
  include Card::Pinnable
  include Card::Watchable
end
```
