---
name: ruby-testing
description: This skill should be used when writing or editing Ruby test files. Covers RSpec and Minitest conventions, test organization, and best practices.
---

# Ruby Testing Conventions

Conventions for writing clear, maintainable tests in RSpec and Minitest.

## General Principles

### Test Organization

1. **Arrange-Act-Assert (AAA)** - Structure each test clearly
2. **One assertion per test** - Test one behavior at a time
3. **Descriptive names** - Tests should document behavior
4. **No logic in tests** - Avoid conditionals and loops

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

```ruby
# Class or module
RSpec.describe User do
  # Instance method
  describe "#full_name" do
    it "concatenates first and last name" do
      user = User.new(first_name: "John", last_name: "Doe")
      expect(user.full_name).to eq("John Doe")
    end
  end

  # Class method
  describe ".find_by_email" do
    it "returns user with matching email" do
      user = User.create!(email: "test@example.com")
      expect(User.find_by_email("test@example.com")).to eq(user)
    end
  end
end
```

### Context Blocks

Use `context` for different scenarios:

```ruby
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

  context "when order is shipped" do
    it "returns shipped" do
      order = Order.new(shipped_at: Time.current)
      expect(order.status).to eq(:shipped)
    end
  end
end
```

### Let and Subject

```ruby
RSpec.describe Order do
  # Lazy-evaluated, memoized
  let(:user) { User.create!(email: "test@example.com") }
  let(:order) { Order.new(user: user, total: 100) }

  # For the primary object under test
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

  teardown do
    # Cleanup if needed
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
# Use in tests
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
# Stub method
allow(ExternalApi).to receive(:fetch).and_return({ data: [] })

# Verify call
expect(mailer).to receive(:deliver_later)

# Partial double
allow(user).to receive(:admin?).and_return(true)
```

### Minitest Mocks

```ruby
# Using Mocha
ExternalApi.stubs(:fetch).returns({ data: [] })
mailer.expects(:deliver_later)
```

## Test Naming

### RSpec

```ruby
# Good - describes behavior
it "returns nil when user not found"
it "raises error for invalid input"
it "sends welcome email after creation"

# Bad - describes implementation
it "calls find_by on User"
it "uses the mailer"
```

### Minitest

```ruby
# Good
test "user with no orders has zero total"
test "invalid email prevents save"
test "admin can access dashboard"

# Bad
test "test1"
test "it works"
```

## Summary

1. Structure tests with AAA pattern
2. One behavior per test
3. Use `describe`/`context` (RSpec) or descriptive test names (Minitest)
4. Prefer factories or fixtures over inline setup
5. Mock external services, not internal objects
6. Name tests to describe behavior
