# Model Scoping

Ensure all queries are scoped to the current account.

## Default Scope Approach

```ruby
class Card < ApplicationRecord
  belongs_to :account

  # Automatic scoping when Current.account is set
  default_scope { where(account: Current.account) if Current.account }
end
```

**Caution:** Default scopes can be surprising. Consider explicit scoping instead.

## Explicit Scoping (Preferred)

```ruby
class CardsController < ApplicationController
  def index
    @cards = Current.account.cards
  end

  def show
    @card = Current.account.cards.find(params[:id])
  end
end
```

## Scoped Associations

```ruby
class Account < ApplicationRecord
  has_many :cards
  has_many :boards
  has_many :users, through: :memberships
end

# Always access through account
Current.account.cards.find(params[:id])
Current.account.boards.active
```

## Default Values

```ruby
class Card < ApplicationRecord
  belongs_to :account, default: -> { Current.account }
  belongs_to :creator, class_name: "User", default: -> { Current.user }
end

# Automatically sets account on create
Card.create!(title: "New card")  # account is Current.account
```

## Database Constraints

Add foreign key constraints for safety:

```ruby
class AddAccountToCards < ActiveRecord::Migration[7.1]
  def change
    add_reference :cards, :account, null: false, foreign_key: true, type: :uuid
  end
end
```

## Preventing Cross-Tenant Access

```ruby
class ApplicationController < ActionController::Base
  before_action :set_current_account
  before_action :verify_account_access

  private
    def set_current_account
      if account_id = request.env["fizzy.account_id"]
        Current.account = Account.find_by!(external_account_id: account_id)
      end
    end

    def verify_account_access
      unless Current.user&.can_access?(Current.account)
        raise ActiveRecord::RecordNotFound
      end
    end
end
```

## Query Patterns

```ruby
# Always scope to account
Current.account.cards.where(status: :open)
Current.account.boards.includes(:cards)

# Never do this (bypasses tenancy)
Card.find(params[:id])  # Dangerous!
Card.where(status: :open)  # Dangerous!
```
