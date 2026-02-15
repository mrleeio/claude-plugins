---
name: rails-current-attributes
description: Use when working with CurrentAttributes for request-scoped state like current user or account. Covers thread-local state and context access patterns.
---

# CurrentAttributes Pattern for Request-Scoped State

Use Rails' `CurrentAttributes` to manage request-scoped state like the current user, account, or session. This pattern provides clean access to context throughout your application without threading state through every method call.

## Quick Reference

| Do | Don't |
|----|-------|
| Inherit from `ActiveSupport::CurrentAttributes` | Roll your own thread-local storage |
| Set context in `before_action` | Set `Current` in models or views |
| Use cascading setters for dependent attributes | Set each attribute independently |
| Provide fallback values (e.g., system user) | Return `nil` without fallback |
| Use `with_account` block helpers for temp context | Manually save/restore attributes |
| Call `Current.clear_all` in test teardown | Let state leak between tests |
| Use `default: -> { Current.user }` in associations | Pass `Current.user` manually everywhere |

## Core Implementation

Create a `Current` class that inherits from `ActiveSupport::CurrentAttributes`:

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

  # Block helper for temporary account context
  def with_account(account)
    previous_account = self.account
    self.account = account
    yield
  ensure
    self.account = previous_account
  end
end
```

## Setting Current Context

### In Controllers

Set context early in the request lifecycle using `before_action`:

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_current_account
  before_action :set_current_session

  private
    def set_current_account
      Current.account = Account.find_by!(external_id: params[:account_id])
    end

    def set_current_session
      Current.session = Session.find_by(token: cookies.signed[:session_token])
    end
end
```

### In Background Jobs

Serialize and restore context automatically (see `rails-job-conventions` skill and the multitenancy reference).

## Using Current in Models

### Default Values in Associations

```ruby
class Card < ApplicationRecord
  belongs_to :creator, class_name: "User", default: -> { Current.user }
  belongs_to :account, default: -> { Current.account }
end
```

### Scoping Queries

```ruby
class Card < ApplicationRecord
  scope :for_current_account, -> { where(account: Current.account) }
end
```

### In Callbacks

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

## Testing

### Setup and Teardown

```ruby
# test/test_helper.rb
class ActiveSupport::TestCase
  setup do
    Current.account = accounts(:default)
  end

  teardown do
    Current.clear_all
  end
end
```

### Temporarily Changing Context

```ruby
def test_with_different_account
  Current.with_account(accounts(:other)) do
    # Test code runs with different account context
    assert_equal accounts(:other), Current.account
  end
  # Original account restored
end
```

## Common Mistakes

1. **Setting Current outside controllers**: `Current` attributes should only be set in controller `before_action` callbacks or job setup. Setting them in models or views creates hidden dependencies
2. **Forgetting `Current.clear_all` in tests**: Without clearing, state from one test leaks into the next. Always call `Current.clear_all` in teardown
3. **Not using cascading setters**: Setting `session`, `identity`, and `user` independently can lead to inconsistent state. Use cascading setters so setting `session` automatically derives `user`
4. **Missing fallback values**: `Current.user` returning `nil` causes `NoMethodError` downstream. Provide a fallback like `account&.system_user`
5. **Directly accessing `Thread.current`**: Use `ActiveSupport::CurrentAttributes` instead of rolling your own thread-local storage. It handles reset-on-request automatically
6. **Not preserving context in jobs**: Background jobs run in a different thread. Serialize `Current.account` and restore it in the job (see the multitenancy reference)
7. **Using `Current` in migrations**: Migrations run outside the request lifecycle. `Current.account` will be `nil`. Pass account explicitly

## Key Principles

1. **Cascading setters**: Setting a parent attribute (like `session`) automatically sets child attributes (like `user`)
2. **Fallback values**: Provide sensible defaults (e.g., system user when no user is logged in)
3. **Block helpers**: Use `with_account` style methods for temporary context changes
4. **Clear on teardown**: Always call `Current.clear_all` in test teardown to prevent state leakage
5. **Thread-safe**: `CurrentAttributes` is automatically thread-safe and request-isolated

## See Also

- [Cascading Setters](references/cascading-setters.md) - Automatic attribute chaining
- [Scoping](references/scoping.md) - Default values and query scoping
- [Testing](references/testing.md) - Setup, teardown, and context switching
