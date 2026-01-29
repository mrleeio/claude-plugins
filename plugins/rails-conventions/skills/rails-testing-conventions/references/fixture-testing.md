# Fixture-Based Testing Patterns

> **Note**: This is an alternative to RSpec/factories. Use Rails fixtures for fast, predictable test data. This guide covers fixture setup, multi-tenant test configuration, and helper patterns.

## Test Helper Setup

```ruby
# test/test_helper.rb
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize workers: :number_of_processors

    # Load all fixtures
    fixtures :all

    # Include custom helpers
    include ActiveJob::TestHelper
    include SessionTestHelper

    # Set default account context for all tests
    setup do
      Current.account = accounts(:default)
    end

    # Clear context after each test to prevent leakage
    teardown do
      Current.clear_all
    end
  end
end
```

## Integration Test Setup

Integration tests need the account prefix in URLs:

```ruby
# test/test_helper.rb
class ActionDispatch::IntegrationTest
  setup do
    # Simulate the URL prefix middleware
    integration_session.default_url_options[:script_name] = "/#{accounts(:default).external_id}"
  end
end
```

## System Test Setup

```ruby
# test/test_helper.rb
class ActionDispatch::SystemTestCase
  setup do
    self.default_url_options[:script_name] = "/#{accounts(:default).external_id}"
  end
end
```

## Session Test Helper

```ruby
# test/test_helpers/session_test_helper.rb
module SessionTestHelper
  def sign_in_as(identity_or_user)
    # Handle both User and Identity
    if identity_or_user.is_a?(User)
      identity = identity_or_user.identity
    elsif identity_or_user.is_a?(Symbol)
      identity = identities(identity_or_user)
    else
      identity = identity_or_user
    end

    # Trigger magic link flow
    identity.send_magic_link
    magic_link = identity.magic_links.order(id: :desc).first

    untenanted do
      post session_path, params: { email_address: identity.email_address }
      post session_magic_link_path, params: { code: magic_link.code }
    end

    assert_response :redirect
    assert cookies[:session_token].present?
  end

  def sign_out
    untenanted do
      delete session_path
    end
  end

  # Execute requests without tenant prefix
  def untenanted
    original_script_name = integration_session.default_url_options[:script_name]
    integration_session.default_url_options[:script_name] = ""
    yield
  ensure
    integration_session.default_url_options[:script_name] = original_script_name
  end

  # Temporarily change current user in unit tests
  def with_current_user(user)
    user = users(user) if user.is_a?(Symbol)
    old_session = Current.session
    Current.session = Session.new(identity: user.identity)
    yield
  ensure
    Current.session = old_session
  end
end
```

## Fixture Files

### accounts.yml

```yaml
# test/fixtures/accounts.yml
default:
  name: "Default Company"
  external_id: "1234567"

other:
  name: "Other Company"
  external_id: "7654321"
```

### users.yml

```yaml
# test/fixtures/users.yml
alice:
  account: default
  identity: alice
  name: "Alice"
  role: admin

bob:
  account: default
  identity: bob
  name: "Bob"
  role: member

other_user:
  account: other
  identity: other_identity
  name: "Other User"
  role: member
```

### Referencing fixtures

```yaml
# test/fixtures/cards.yml
bug_report:
  account: default
  board: engineering
  column: todo
  creator: alice
  title: "Fix login bug"

feature_request:
  account: default
  board: engineering
  column: in_progress
  creator: bob
  title: "Add dark mode"
```

## Unit Test Example

```ruby
# test/models/card_test.rb
class CardTest < ActiveSupport::TestCase
  setup do
    @card = cards(:bug_report)
  end

  test "close marks card as closed" do
    assert @card.open?

    @card.close(user: users(:alice))

    assert @card.closed?
    assert_equal users(:alice), @card.closed_by
  end

  test "reopen marks card as open" do
    @card.close
    assert @card.closed?

    @card.reopen

    assert @card.open?
  end

  test "tracks close event" do
    assert_difference -> { @card.events.count }, 1 do
      @card.close
    end

    event = @card.events.last
    assert_equal "closed", event.action
    assert_equal Current.user, event.creator
  end
end
```

## Integration Test Example

```ruby
# test/integration/cards_test.rb
class CardsTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as :alice
    @board = boards(:engineering)
  end

  test "create a new card" do
    assert_difference -> { Card.count }, 1 do
      post board_cards_path(@board), params: {
        card: { title: "New card", description: "Description" }
      }
    end

    assert_redirected_to card_path(Card.last)
  end

  test "close a card" do
    card = cards(:bug_report)

    post card_closure_path(card)

    assert_redirected_to card_path(card)
    assert card.reload.closed?
  end
end
```

## System Test Example

```ruby
# test/system/cards_test.rb
class CardsSystemTest < ApplicationSystemTestCase
  setup do
    sign_in_as :alice
  end

  test "creating a card" do
    visit board_path(boards(:engineering))

    click_on "New Card"
    fill_in "Title", with: "System test card"
    click_on "Create Card"

    assert_text "System test card"
  end
end
```

## Testing Different Accounts

```ruby
test "users cannot see other account's cards" do
  other_card = cards(:other_account_card)

  get card_path(other_card)

  assert_response :not_found
end

test "operates on correct account" do
  Current.account = accounts(:other)

  card = accounts(:other).cards.create!(
    title: "Other account card",
    board: boards(:other_board)
  )

  assert_equal accounts(:other), card.account
end
```

## Fixture Testing vs RSpec/Factories

| Aspect | Fixtures | RSpec/Factories |
|--------|----------|-----------------|
| Speed | Faster (loaded once) | Slower (built per test) |
| Setup | YAML files | Ruby DSL |
| Data | Static, predictable | Dynamic, flexible |
| Relationships | Via fixture names | Via associations |
| Best for | Multi-tenant apps | Complex object graphs |

## Best Practices

1. **Set `Current.account` in setup**: Every test starts with consistent context
2. **Clear context in teardown**: Prevent state leakage between tests
3. **Use `script_name` for integration tests**: Simulate URL-based multi-tenancy
4. **Use fixture helpers**: `cards(:bug_report)` is cleaner than `Card.find_by(title: "...")`
5. **Test cross-account isolation**: Verify users can't access other accounts' data
6. **Use `untenanted` for auth routes**: Login/logout routes don't have account prefix
