# RSpec Reference

Complete API reference for RSpec testing.

## Core Structure

### Example Groups

```ruby
RSpec.describe ClassName do
  describe "#instance_method" do
    context "when condition" do
      it "does something" do
        # test
      end
    end
  end

  describe ".class_method" do
    # tests
  end
end
```

### Examples

```ruby
it "description" do
  # single example
end

specify "alternative to it" do
  # same as it
end

example "another alternative" do
  # same as it
end

pending "not yet implemented"

skip "temporarily disabled"

xit "disabled example" do
  # won't run
end
```

## Let and Subject

### let (lazy, memoized)

```ruby
let(:user) { User.new(name: "John") }
let(:order) { Order.new(user: user) }

# Evaluated on first access, cached per example
it "uses let values" do
  expect(user.name).to eq("John")
  expect(order.user).to eq(user)  # same instance
end
```

### let! (eager)

```ruby
let!(:user) { User.create!(name: "John") }

# Evaluated before each example, even if not accessed
it "user exists" do
  expect(User.count).to eq(1)
end
```

### subject

```ruby
# Implicit subject (described class)
RSpec.describe User do
  it { is_expected.to respond_to(:name) }
end

# Named subject
subject(:order) { Order.new(total: 100) }

it "has total" do
  expect(order.total).to eq(100)
end
```

## Expectations

### Basic Matchers

```ruby
expect(actual).to eq(expected)       # equality
expect(actual).to eql(expected)      # type + value equality
expect(actual).to equal(expected)    # identity (same object)
expect(actual).to be(expected)       # identity (same object)

expect(actual).to be_nil
expect(actual).to be_truthy
expect(actual).to be_falsey

expect(actual).to be > 5
expect(actual).to be_between(1, 10).inclusive
expect(actual).to be_within(0.1).of(3.14)
```

### Predicate Matchers

```ruby
# Calls actual.valid?
expect(user).to be_valid

# Calls actual.admin?
expect(user).to be_admin

# Calls actual.has_key?(:name)
expect(hash).to have_key(:name)

# Calls actual.empty?
expect(array).to be_empty
```

### Collection Matchers

```ruby
expect(array).to include(1, 2, 3)
expect(array).to contain_exactly(3, 2, 1)  # order independent
expect(array).to match_array([3, 2, 1])    # same as contain_exactly
expect(array).to start_with(1)
expect(array).to end_with(3)
expect(array).to all(be > 0)

expect(hash).to include(name: "John")
expect(hash).to include(:name, :email)
```

### String Matchers

```ruby
expect(string).to include("substring")
expect(string).to start_with("prefix")
expect(string).to end_with("suffix")
expect(string).to match(/regex/)
```

### Error Matchers

```ruby
expect { raise_error }.to raise_error
expect { raise_error }.to raise_error(ArgumentError)
expect { raise_error }.to raise_error(ArgumentError, "message")
expect { raise_error }.to raise_error(/pattern/)

expect { code }.not_to raise_error
```

### Change Matchers

```ruby
expect { user.save }.to change(User, :count).by(1)
expect { user.save }.to change(User, :count).from(0).to(1)
expect { user.name = "New" }.to change(user, :name)
expect { user.name = "New" }.to change { user.name }.to("New")
```

### Output Matchers

```ruby
expect { puts "hello" }.to output("hello\n").to_stdout
expect { warn "oops" }.to output(/oops/).to_stderr
```

### Compound Expectations

```ruby
expect(value).to be > 5 and be < 10
expect(value).to be > 5 & be < 10    # same

expect(value).to eq(1).or eq(2)
expect(value).to eq(1) | eq(2)       # same
```

## Hooks

### before/after

```ruby
before(:each) { }   # before each example (default)
before(:all) { }    # before all examples in group
before(:suite) { }  # before entire suite

after(:each) { }
after(:all) { }
after(:suite) { }

# Shorthand
before { }    # same as before(:each)
after { }     # same as after(:each)
```

### around

```ruby
around(:each) do |example|
  # setup
  example.run
  # teardown
end
```

## Shared Examples

### Define

```ruby
RSpec.shared_examples "a collection" do
  it "responds to each" do
    expect(subject).to respond_to(:each)
  end

  it "responds to size" do
    expect(subject).to respond_to(:size)
  end
end

RSpec.shared_examples "sortable" do |method|
  it "can be sorted by #{method}" do
    expect(subject).to respond_to("sort_by_#{method}")
  end
end
```

### Use

```ruby
RSpec.describe Array do
  it_behaves_like "a collection"
  include_examples "a collection"      # same
  it_should_behave_like "a collection" # same
end

RSpec.describe User do
  it_behaves_like "sortable", :name
  it_behaves_like "sortable", :created_at
end
```

## Shared Context

```ruby
RSpec.shared_context "authenticated user" do
  let(:user) { create(:user) }
  before { sign_in(user) }
end

RSpec.describe "Dashboard" do
  include_context "authenticated user"

  it "shows user name" do
    expect(page).to have_content(user.name)
  end
end
```

## Mocks and Stubs

### Test Doubles

```ruby
user = double("User")
user = double("User", name: "John", admin?: true)

user = instance_double(User)  # verifies methods exist
user = class_double(User)     # for class methods
user = object_double(existing_user)  # wraps real object
```

### Stubbing

```ruby
allow(object).to receive(:method).and_return(value)
allow(object).to receive(:method) { value }
allow(object).to receive(:method).with(arg).and_return(value)

allow(object).to receive_messages(foo: 1, bar: 2)
```

### Expectations (Mocks)

```ruby
expect(object).to receive(:method)
expect(object).to receive(:method).with(arg)
expect(object).to receive(:method).once
expect(object).to receive(:method).twice
expect(object).to receive(:method).exactly(3).times
expect(object).to receive(:method).at_least(:once)
expect(object).to receive(:method).at_most(5).times

expect(object).to receive(:method).ordered
expect(object).to receive(:other_method).ordered
```

### Spies

```ruby
user = spy("User")
user.name
user.save

expect(user).to have_received(:name)
expect(user).to have_received(:save)
```

## Metadata and Filtering

```ruby
it "slow test", :slow do
  # tagged with :slow
end

it "integration", type: :feature do
  # tagged with type
end

# Run only tagged tests
# rspec --tag slow
# rspec --tag type:feature
```

## Pending and Skipping

```ruby
pending "not yet implemented"

it "future feature" do
  pending "waiting for API"
  expect(feature).to work
end

skip "reason for skipping"

it "temporarily disabled" do
  skip "debugging something else"
end

xit "disabled example" do
  # won't run
end

xdescribe "disabled group" do
  # none will run
end
```
