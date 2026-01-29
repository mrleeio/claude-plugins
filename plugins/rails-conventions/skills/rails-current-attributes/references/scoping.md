# Scoping with CurrentAttributes

Use Current attributes to scope queries and set defaults.

## Default Values in Associations

```ruby
class Card < ApplicationRecord
  belongs_to :creator, class_name: "User", default: -> { Current.user }
  belongs_to :account, default: -> { Current.account }
end

# Usage
Card.create!(title: "New card")
# creator and account are automatically set from Current
```

## Scoping Queries

```ruby
class Card < ApplicationRecord
  scope :for_current_account, -> { where(account: Current.account) }
end

# Usage
Card.for_current_account.active
```

## In Model Callbacks

```ruby
class Comment < ApplicationRecord
  after_create_commit :notify_watchers

  private
    def notify_watchers
      # Current.user is available here
      card.watchers.excluding(Current.user).each do |watcher|
        NotificationJob.perform_later(watcher, self)
      end
    end
end
```

## Temporary Context Changes

```ruby
# app/models/current.rb
class Current < ActiveSupport::CurrentAttributes
  def with_account(account)
    previous_account = self.account
    self.account = account
    yield
  ensure
    self.account = previous_account
  end
end

# Usage
Current.with_account(other_account) do
  # All queries scoped to other_account
  other_account.cards.each { |card| card.process }
end
# Back to original account
```

## In Background Jobs

```ruby
class ProcessCardJob < ApplicationJob
  def perform(card)
    # Set context for the job
    Current.account = card.account
    Current.user = card.creator

    card.process
  ensure
    Current.clear_all
  end
end
```

## Query Patterns

```ruby
# Explicit scoping (preferred)
Current.account.cards.find(params[:id])

# Scope method
Card.for_current_account.find(params[:id])

# Default scope (use with caution)
class Card < ApplicationRecord
  default_scope { where(account: Current.account) if Current.account }
end
```

## Avoid Unscoped Queries

```ruby
# Dangerous - bypasses tenancy
Card.find(params[:id])

# Safe - scoped to current account
Current.account.cards.find(params[:id])
```
