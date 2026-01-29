# Test Setup for Multi-Tenancy

Configure tests to work with path-based multi-tenancy.

## Integration Tests

```ruby
# test/test_helper.rb
class ActionDispatch::IntegrationTest
  setup do
    # Set the script_name to simulate the account prefix
    integration_session.default_url_options[:script_name] = "/#{accounts(:default).external_account_id}"
  end
end
```

## System Tests

```ruby
# test/application_system_test_case.rb
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  setup do
    self.default_url_options[:script_name] = "/#{accounts(:default).external_account_id}"
  end
end
```

## Untenanted Request Helper

For routes that don't require tenant context (login, signup, etc.):

```ruby
# test/support/session_test_helper.rb
module SessionTestHelper
  def untenanted(&block)
    original_script_name = integration_session.default_url_options[:script_name]
    integration_session.default_url_options[:script_name] = ""
    yield
  ensure
    integration_session.default_url_options[:script_name] = original_script_name
  end
end

# Include in test helper
class ActionDispatch::IntegrationTest
  include SessionTestHelper
end
```

Usage:

```ruby
class SessionsTest < ActionDispatch::IntegrationTest
  test "login" do
    untenanted do
      post session_path, params: { email: "user@example.com" }
      assert_redirected_to root_path
    end
  end
end
```

## Switching Accounts in Tests

```ruby
# test/support/tenancy_helper.rb
module TenancyHelper
  def with_account(account)
    original_account = Current.account
    Current.account = account
    integration_session.default_url_options[:script_name] = "/#{account.external_account_id}"
    yield
  ensure
    Current.account = original_account
    integration_session.default_url_options[:script_name] = "/#{original_account&.external_account_id}"
  end
end
```

Usage:

```ruby
test "cross-account access denied" do
  with_account(accounts(:other)) do
    get card_path(cards(:from_default_account))
    assert_response :not_found
  end
end
```

## Unit Tests

```ruby
class ActiveSupport::TestCase
  setup do
    Current.account = accounts(:default)
  end

  teardown do
    Current.clear_all
  end
end
```

## Fixtures

```yaml
# test/fixtures/accounts.yml
default:
  external_account_id: "12345678"
  name: "Default Account"

other:
  external_account_id: "87654321"
  name: "Other Account"

# test/fixtures/cards.yml
one:
  account: default
  title: "Card One"
```
