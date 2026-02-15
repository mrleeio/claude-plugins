---
name: ruby-testing
description: This skill should be used when writing or editing Ruby test files. Covers RSpec and Minitest conventions, test organization, and best practices.
---

# Ruby Testing Conventions

NEVER test mocked behavior. ALWAYS use Arrange-Act-Assert. Test one behavior per test.

## Quick Reference

| Do | Don't |
|----|-------|
| Structure tests with Arrange-Act-Assert | Mix setup, action, and assertions |
| Test one behavior per test | Assert multiple unrelated things |
| Test public interface behavior | Test private methods directly |
| Use descriptive test names that document behavior | Name tests `test1` or `it works` |
| Mock external services (APIs, payment processors) | Mock the object under test |
| Use factories or fixtures for test data | Build complex objects inline |
| Use `describe`/`context` to organize (RSpec) | Put all tests in flat structure |
| Start `context` blocks with "when" or "with" | Use vague context descriptions |
| Use `let` for lazy-evaluated test data (RSpec) | Use instance variables in `before` blocks |
| Test edge cases and error conditions | Only test the happy path |

## Core Rules

```ruby
# WRONG - testing mocked behavior, no structure, multiple assertions
it "processes the order" do
  allow(order).to receive(:total).and_return(100)
  allow(order).to receive(:process).and_return(true)
  result = order.process
  expect(result).to be true
  expect(order).to have_received(:process)
  expect(order.total).to eq(100)
end

# RIGHT - testing real behavior, AAA structure, one assertion
it "calculates total from line items" do
  # Arrange
  order = Order.new(line_items: [LineItem.new(price: 50), LineItem.new(price: 30)])

  # Act
  total = order.total

  # Assert
  expect(total).to eq(80)
end
```

## Test Organization

### What to Test

- Public interface behavior
- Edge cases and error conditions
- Integration points
- Business rules

### What NOT to Test

- Private methods directly
- Framework behavior (Rails validations work)
- External service internals

## RSpec Conventions

See `references/rspec.md` for complete API reference.

### Describe Blocks

Use `describe` for the class/method being tested:

```ruby
RSpec.describe User do
  # Instance method - prefix with #
  describe "#full_name" do
    it "concatenates first and last name" do
      user = User.new(first_name: "John", last_name: "Doe")
      expect(user.full_name).to eq("John Doe")
    end
  end

  # Class method - prefix with .
  describe ".find_by_email" do
    it "returns user with matching email" do
      user = User.create!(email: "test@example.com")
      expect(User.find_by_email("test@example.com")).to eq(user)
    end
  end
end
```

### Context Blocks

Use `context` for different scenarios. Always start with "when" or "with":

```ruby
# WRONG
context "new order" do; end
context "paid" do; end

# RIGHT
describe "#status" do
  context "when order is new" do
    it "returns pending" do
      order = Order.new
      expect(order.status).to eq(:pending)
    end
  end

  context "when order is paid" do
    it "returns confirmed" do
      order = Order.new(paid_at: Time.current)
      expect(order.status).to eq(:confirmed)
    end
  end
end
```

### Let and Subject

Use `let` for lazy-evaluated, memoized test data. Use `subject` for the primary object under test:

```ruby
RSpec.describe Order do
  let(:user) { User.create!(email: "test@example.com") }
  let(:order) { Order.new(user: user, total: 100) }

  subject(:order) { Order.new(user: user) }

  describe "#valid?" do
    it "requires a user" do
      order = Order.new(user: nil)
      expect(order).not_to be_valid
    end
  end
end
```

### Shared Examples

Extract common behavior checks into shared examples:

```ruby
# Define
RSpec.shared_examples "a timestamped record" do
  it "has created_at" do
    expect(subject).to respond_to(:created_at)
  end

  it "has updated_at" do
    expect(subject).to respond_to(:updated_at)
  end
end

# Use
RSpec.describe User do
  subject { User.new }
  it_behaves_like "a timestamped record"
end
```

## Minitest Conventions

See `references/minitest.md` for complete API reference.

### Test Classes

```ruby
class UserTest < ActiveSupport::TestCase
  test "full_name concatenates first and last name" do
    user = User.new(first_name: "John", last_name: "Doe")
    assert_equal "John Doe", user.full_name
  end

  test "email must be present" do
    user = User.new(email: nil)
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end
end
```

### Setup and Teardown

```ruby
class OrderTest < ActiveSupport::TestCase
  setup do
    @user = users(:alice)
    @order = Order.new(user: @user)
  end

  test "calculates total with tax" do
    @order.subtotal = 100
    assert_equal 108, @order.total_with_tax
  end
end
```

### Assertions

```ruby
# Equality
assert_equal expected, actual
assert_not_equal unexpected, actual

# Truth
assert condition
assert_not condition

# Nil
assert_nil value
assert_not_nil value

# Collections
assert_includes collection, item
assert_empty collection

# Exceptions
assert_raises(ArgumentError) { method_that_raises }

# Changes
assert_difference("User.count", 1) do
  User.create!(email: "new@example.com")
end
```

## Test Data

### Factories (FactoryBot)

```ruby
# Define
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { "John" }
    last_name { "Doe" }

    trait :admin do
      role { :admin }
    end

    trait :with_orders do
      after(:create) do |user|
        create_list(:order, 3, user: user)
      end
    end
  end
end

# Use
let(:user) { create(:user) }
let(:admin) { create(:user, :admin) }
let(:user_with_orders) { create(:user, :with_orders) }
```

### Fixtures

```yaml
# test/fixtures/users.yml
alice:
  email: alice@example.com
  first_name: Alice
  role: admin

bob:
  email: bob@example.com
  first_name: Bob
  role: member
```

```ruby
test "admin can delete users" do
  admin = users(:alice)
  member = users(:bob)
  # ...
end
```

## Mocking and Stubbing

### When to Mock

- External services (APIs, payment processors)
- Time-dependent behavior
- Expensive operations
- Non-deterministic results

### When NOT to Mock

- The object under test
- Simple value objects
- Database interactions (usually)

### RSpec Mocks

```ruby
# WRONG - mocking the object under test
allow(user).to receive(:full_name).and_return("John Doe")
expect(user.full_name).to eq("John Doe")  # Tests nothing!

# RIGHT - mocking external dependency
allow(ExternalApi).to receive(:fetch).and_return({ data: [] })
result = processor.process
expect(result).to eq([])
```

## Test Naming

### RSpec

```ruby
# WRONG - describes implementation
it "calls find_by on User"
it "uses the mailer"

# RIGHT - describes behavior
it "returns nil when user not found"
it "raises error for invalid input"
it "sends welcome email after creation"
```

### Minitest

```ruby
# WRONG
test "test1"
test "it works"

# RIGHT
test "user with no orders has zero total"
test "invalid email prevents save"
test "admin can access dashboard"
```

## Common Mistakes

1. **Mocking the object under test**: If you mock the object you're testing, you're testing the mock, not the code. Only mock external collaborators
2. **Multiple unrelated assertions**: Each test should verify one behavior. Multiple assertions testing different behaviors make failures harder to diagnose
3. **Testing private methods**: Test the public interface. Private methods are implementation details that should be covered through public method tests
4. **Vague test names**: Names like "it works" or "test1" provide no documentation value. Describe the expected behavior
5. **Shared state between tests**: Tests that depend on order or shared mutable state are fragile. Each test should set up its own data
6. **Over-mocking**: If you need many mocks to test something, the code has too many dependencies. Refactor the code first
7. **Testing framework internals**: Don't test that `validates :email, presence: true` works. Test your business logic
8. **Missing edge cases**: Always test nil inputs, empty collections, boundary conditions, and error paths

## See Also

- `references/rspec.md` - Complete RSpec API reference
- `references/minitest.md` - Complete Minitest API reference
