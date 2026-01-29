# Cascading Setters

Set related attributes automatically when a parent attribute is set.

## Pattern

```ruby
# app/models/current.rb
class Current < ActiveSupport::CurrentAttributes
  attribute :account, :session

  # Cascading setter: setting session automatically sets identity and user
  def session=(session)
    super
    self.identity = session&.identity
  end

  def identity=(identity)
    @identity = identity
    self.user = identity&.user_for(account)
  end

  def identity
    @identity
  end

  def user=(user)
    @user = user
  end

  def user
    @user || account&.system_user
  end
end
```

## How It Works

1. Controller sets `Current.session = session`
2. Session setter automatically sets `identity` from session
3. Identity setter automatically sets `user` from identity
4. Result: One assignment cascades through the chain

## Benefits

| Benefit | Explanation |
|---------|-------------|
| Single entry point | Controller only needs to set `session` |
| Derived values | `user` is derived from `session` automatically |
| Fallback values | `user` falls back to `system_user` if not set |
| Encapsulation | Logic lives in Current, not controllers |

## Usage in Controllers

```ruby
class ApplicationController < ActionController::Base
  before_action :set_current_account
  before_action :set_current_session

  private
    def set_current_account
      Current.account = Account.find_by!(external_id: params[:account_id])
    end

    def set_current_session
      # This one assignment sets session, identity, and user
      Current.session = Session.find_by(token: cookies.signed[:session_token])
    end
end
```

## Fallback Values

```ruby
def user
  @user || account&.system_user
end
```

When no user is logged in, `Current.user` returns the account's system user. This allows code to always reference `Current.user` without nil checks.

## Order Matters

Set attributes in dependency order:

```ruby
# In controller
before_action :set_current_account  # First: account has no dependencies
before_action :set_current_session  # Second: session uses account

# In Current
def identity=(identity)
  @identity = identity
  self.user = identity&.user_for(account)  # Needs account to be set
end
```
