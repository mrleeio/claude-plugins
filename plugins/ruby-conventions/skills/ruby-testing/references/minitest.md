# Minitest Reference

Complete API reference for Minitest testing.

## Core Structure

### Test Classes

```ruby
require "minitest/autorun"

class UserTest < Minitest::Test
  def test_something
    # test code
  end
end

# Rails style
class UserTest < ActiveSupport::TestCase
  test "description of test" do
    # test code
  end
end
```

### Setup and Teardown

```ruby
class UserTest < Minitest::Test
  def setup
    @user = User.new(name: "John")
  end

  def teardown
    # cleanup
  end

  def test_name
    assert_equal "John", @user.name
  end
end

# Rails style
class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:john)
  end

  teardown do
    # cleanup
  end
end
```

## Assertions

### Equality

```ruby
assert_equal expected, actual
assert_equal expected, actual, "optional message"

refute_equal unexpected, actual
assert_not_equal unexpected, actual  # Rails alias
```

### Truth

```ruby
assert condition
assert condition, "message"
assert_not condition        # Rails
refute condition            # Minitest

assert_predicate object, :empty?
refute_predicate object, :empty?
```

### Nil

```ruby
assert_nil value
refute_nil value
assert_not_nil value  # Rails alias
```

### Boolean

```ruby
# Direct comparison
assert_equal true, value
assert_equal false, value

# Or use assert/refute
assert value
refute value
```

### Identity

```ruby
assert_same expected, actual      # same object
refute_same expected, actual
```

### Type

```ruby
assert_instance_of String, value
refute_instance_of String, value

assert_kind_of Enumerable, value
refute_kind_of Enumerable, value
```

### Pattern Matching

```ruby
assert_match /pattern/, string
refute_match /pattern/, string

assert_match(/\d+/, "abc123")
```

### Collections

```ruby
assert_includes collection, element
refute_includes collection, element

assert_empty collection
refute_empty collection

# Size
assert_equal 3, array.size
```

### Exceptions

```ruby
assert_raises(ArgumentError) do
  method_that_raises
end

error = assert_raises(CustomError) do
  method_that_raises
end
assert_equal "message", error.message

assert_nothing_raised do
  safe_method
end
```

### Output

```ruby
assert_output("expected stdout") do
  puts "expected stdout"
end

assert_output("stdout", "stderr") do
  puts "stdout"
  warn "stderr"
end

assert_silent do
  # no output
end
```

### Respond To

```ruby
assert_respond_to object, :method_name
refute_respond_to object, :method_name
```

### Delta (Floating Point)

```ruby
assert_in_delta expected, actual, delta
assert_in_delta 3.14, calculated, 0.01

assert_in_epsilon expected, actual, epsilon
```

### Operators

```ruby
assert_operator value, :>, 5
assert_operator value, :<, 10
assert_operator array, :include?, element
```

## Rails-Specific Assertions

### Changes

```ruby
assert_difference("User.count", 1) do
  User.create!(email: "new@example.com")
end

assert_difference("User.count", -1) do
  user.destroy
end

assert_no_difference("User.count") do
  User.new.save  # invalid, won't save
end

# Multiple
assert_difference(["User.count", "Profile.count"], 1) do
  create_user_with_profile
end
```

### Enqueued Jobs

```ruby
assert_enqueued_jobs 1 do
  UserMailer.welcome(user).deliver_later
end

assert_enqueued_with(job: WelcomeEmailJob, args: [user]) do
  user.welcome!
end

assert_no_enqueued_jobs do
  # no jobs enqueued
end
```

### Enqueued Emails

```ruby
assert_emails 1 do
  UserMailer.welcome(user).deliver_now
end

assert_no_emails do
  # no emails sent
end
```

### Database Queries

```ruby
assert_queries(2) do
  User.find(1)
  Post.find(1)
end

assert_no_queries do
  cached_result
end
```

## Spec-Style (Minitest::Spec)

```ruby
require "minitest/autorun"

describe User do
  before do
    @user = User.new(name: "John")
  end

  after do
    # cleanup
  end

  describe "#full_name" do
    it "returns first and last name" do
      _(@user.full_name).must_equal "John Doe"
    end
  end

  describe ".find_by_email" do
    it "returns nil when not found" do
      _(User.find_by_email("none@example.com")).must_be_nil
    end
  end
end
```

### Spec Expectations

```ruby
_(value).must_equal expected
_(value).wont_equal expected

_(value).must_be :>, 5
_(value).must_be_nil
_(value).wont_be_nil

_(collection).must_include element
_(collection).must_be_empty

_(value).must_match /pattern/
_(value).must_be_instance_of String
_(value).must_respond_to :method

_{ code }.must_raise ArgumentError
_{ code }.must_output "stdout"
```

## Skipping Tests

```ruby
def test_future_feature
  skip "not implemented yet"
end

def test_platform_specific
  skip "only runs on linux" unless RUBY_PLATFORM.include?("linux")
end
```

## Mocking (with Mocha)

```ruby
# Stubbing
User.stubs(:find).returns(user)
object.stubs(:method).with(arg).returns(value)

# Expectations
User.expects(:find).with(1).returns(user)
mailer.expects(:deliver_later).once
object.expects(:method).never

# Sequences
sequence = sequence("order")
first.expects(:call).in_sequence(sequence)
second.expects(:call).in_sequence(sequence)
```

## Fixtures

### Defining

```yaml
# test/fixtures/users.yml
john:
  email: john@example.com
  name: John Doe
  role: admin

jane:
  email: jane@example.com
  name: Jane Smith
  role: member
```

### Using

```ruby
class UserTest < ActiveSupport::TestCase
  test "fixture is loaded" do
    john = users(:john)
    assert_equal "john@example.com", john.email
  end
end
```

### ERB in Fixtures

```yaml
generated_user:
  email: <%= "user#{rand(1000)}@example.com" %>
  created_at: <%= 3.days.ago %>
```

## Parallel Testing

```ruby
class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  # Or disable
  parallelize(workers: 1)
end
```

## Test Helpers

```ruby
module TestHelpers
  def sign_in(user)
    # helper code
  end
end

class ActionDispatch::IntegrationTest
  include TestHelpers
end
```
