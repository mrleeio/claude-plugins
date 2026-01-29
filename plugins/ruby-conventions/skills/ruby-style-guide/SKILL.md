---
name: ruby-style-guide
description: This skill should be used when writing or editing Ruby code. Covers naming conventions, method design, class structure, and idiomatic Ruby patterns.
---

# Ruby Style Guide

Conventions for writing clean, idiomatic Ruby code.

## Naming Conventions

### Variables and Methods

```ruby
# snake_case for variables, methods, and symbols
user_name = "Alice"
def calculate_total; end
:payment_status

# SCREAMING_SNAKE_CASE for constants
MAX_RETRY_COUNT = 3
DEFAULT_TIMEOUT = 30

# PascalCase for classes and modules
class UserAccount; end
module PaymentProcessor; end
```

### Predicate Methods

Methods returning boolean values end with `?`:

```ruby
def valid?
  errors.empty?
end

def admin?
  role == :admin
end

def can_edit?(resource)
  owner?(resource) || admin?
end
```

### Bang Methods

Methods with `!` suffix indicate:
- Dangerous operation (modifies receiver in place)
- Raises exception on failure (vs returning nil)

```ruby
# Modifies in place
array.sort!
string.upcase!

# Raises on failure
user.save!      # raises if invalid
record.update!  # raises if update fails
```

## Method Design

### Guard Clauses

Use early returns to reduce nesting:

```ruby
# Good - guard clauses
def process_order(order)
  return unless order.valid?
  return if order.processed?

  order.process
  notify_customer(order)
end

# Bad - deep nesting
def process_order(order)
  if order.valid?
    unless order.processed?
      order.process
      notify_customer(order)
    end
  end
end
```

### Single Responsibility

Each method should do one thing:

```ruby
# Good - separate concerns
def create_user(params)
  user = User.new(params)
  user.save
end

def send_welcome_email(user)
  UserMailer.welcome(user).deliver_later
end

# Bad - multiple responsibilities
def create_user_and_notify(params)
  user = User.new(params)
  if user.save
    UserMailer.welcome(user).deliver_later
    AdminNotifier.new_user(user).deliver_later
    Analytics.track(:user_created, user.id)
  end
  user
end
```

### Method Length

Keep methods under 10 lines. Extract helper methods when longer.

## Class Structure Order

Organize class internals in this order:

```ruby
class User
  # 1. Extend and include
  extend Searchable
  include Authenticatable

  # 2. Constants
  ROLES = %i[admin member guest].freeze

  # 3. Attribute macros
  attr_reader :name
  attr_accessor :email

  # 4. Class-level macros (associations, validations, callbacks)
  belongs_to :organization
  has_many :posts

  validates :email, presence: true
  validates :name, length: { maximum: 100 }

  before_save :normalize_email

  # 5. Public class methods
  def self.find_by_email(email)
    find_by(email: email.downcase)
  end

  # 6. Public instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  # 7. Protected methods
  protected

  def reset_token
    SecureRandom.hex(20)
  end

  # 8. Private methods
  private

  def normalize_email
    self.email = email.downcase.strip
  end
end
```

## Idiomatic Ruby

### Enumerable Methods

Prefer functional methods over loops:

```ruby
# Good
users.select(&:active?).map(&:email)
numbers.sum
items.any?(&:expired?)
orders.find { |o| o.total > 100 }

# Bad
active_emails = []
users.each do |user|
  if user.active?
    active_emails << user.email
  end
end
```

### Symbol-to-Proc

Use `&:method` for simple transformations:

```ruby
# Good
names.map(&:upcase)
users.select(&:admin?)
numbers.reduce(&:+)

# When to use block (complex logic)
users.map { |u| "#{u.first_name} #{u.last_name}" }
```

### Implicit Return

Ruby returns the last expression. Use explicit `return` only for early exits:

```ruby
# Good - implicit return
def full_name
  "#{first_name} #{last_name}"
end

# Good - explicit early return
def process
  return if invalid?

  perform_action
end
```

## String Formatting

### Interpolation over Concatenation

```ruby
# Good
"Hello, #{user.name}!"
"Order ##{order.id} - #{order.status}"

# Bad
"Hello, " + user.name + "!"
```

### Heredocs for Multi-line Strings

```ruby
# Good
message = <<~MSG
  Dear #{user.name},

  Your order has been shipped.

  Thanks,
  The Team
MSG

# Bad
message = "Dear #{user.name},\n\nYour order has been shipped.\n\nThanks,\nThe Team"
```

## Error Handling

### Specific Exceptions

Rescue specific exceptions, not generic `Exception` or `StandardError`:

```ruby
# Good
begin
  process_payment
rescue Stripe::CardError => e
  log_error(e)
  flash[:error] = "Payment failed: #{e.message}"
rescue Stripe::RateLimitError
  retry_later
end

# Bad
begin
  process_payment
rescue => e
  log_error(e)
end
```

### Custom Exceptions

Create domain-specific exceptions:

```ruby
module Payments
  class Error < StandardError; end
  class CardDeclinedError < Error; end
  class InsufficientFundsError < Error; end
end
```

## Collections

### Frozen Collections

Freeze constant collections to prevent modification:

```ruby
VALID_STATUSES = %i[pending active completed cancelled].freeze
DEFAULT_OPTIONS = { timeout: 30, retries: 3 }.freeze
```

### Safe Navigation

Use `&.` for potentially nil receivers:

```ruby
# Good
user&.address&.city

# Equivalent to
user && user.address && user.address.city
```

## Summary

1. Use consistent naming (snake_case, PascalCase, SCREAMING_SNAKE)
2. Design small, focused methods with guard clauses
3. Follow standard class structure ordering
4. Prefer enumerable methods over loops
5. Use string interpolation and heredocs
6. Rescue specific exceptions
7. Freeze constant collections

## See Also

- `references/class-structure.md` - Complete class ordering reference with examples
