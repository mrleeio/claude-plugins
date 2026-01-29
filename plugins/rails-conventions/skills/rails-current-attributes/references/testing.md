# Testing with CurrentAttributes

Setup and teardown patterns for testing code that uses Current.

## Basic Setup

```ruby
# test/test_helper.rb
class ActiveSupport::TestCase
  setup do
    Current.account = accounts(:default)
    Current.user = users(:default)
  end

  teardown do
    Current.clear_all
  end
end
```

## Why Clear on Teardown?

`Current.clear_all` resets all attributes between tests, preventing:
- State leakage between tests
- False positives/negatives from stale context
- Unpredictable test ordering issues

## Temporarily Changing Context

```ruby
def test_with_different_account
  Current.with_account(accounts(:other)) do
    # Test code runs with different account context
    assert_equal accounts(:other), Current.account

    # Queries are scoped to other account
    cards = Card.for_current_account
    assert cards.all? { |c| c.account == accounts(:other) }
  end

  # Original account restored
  assert_equal accounts(:default), Current.account
end
```

## Testing Without Context

```ruby
def test_handles_missing_user
  Current.user = nil

  # Test behavior when no user is logged in
  assert_nil Current.user
  # or test fallback behavior
  assert_equal Current.account.system_user, Current.user
end
```

## Integration Test Setup

```ruby
class ActionDispatch::IntegrationTest
  setup do
    # Current is automatically set by controller before_actions
    # Just ensure fixtures are loaded
  end

  def sign_in(user)
    post session_path, params: { email: user.email, password: "password" }
    # Controller sets Current.session which cascades to Current.user
  end
end
```

## Testing Current Class Directly

```ruby
class CurrentTest < ActiveSupport::TestCase
  teardown { Current.clear_all }

  test "cascading setters" do
    session = sessions(:default)
    Current.account = accounts(:default)
    Current.session = session

    assert_equal session.identity, Current.identity
    assert_equal session.identity.user_for(Current.account), Current.user
  end

  test "fallback to system user" do
    Current.account = accounts(:default)
    Current.session = nil

    assert_equal accounts(:default).system_user, Current.user
  end

  test "with_account block helper" do
    Current.account = accounts(:default)

    Current.with_account(accounts(:other)) do
      assert_equal accounts(:other), Current.account
    end

    assert_equal accounts(:default), Current.account
  end
end
```

## Common Pitfalls

| Pitfall | Solution |
|---------|----------|
| Forgetting to clear | Add `Current.clear_all` to teardown |
| Tests pass alone, fail together | State leaking - check teardown |
| Nil errors in tests | Ensure setup sets required attributes |
| Wrong account in tests | Check test is using right fixture |
