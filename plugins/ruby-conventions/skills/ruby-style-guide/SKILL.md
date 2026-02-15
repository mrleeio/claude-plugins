---
name: ruby-style-guide
description: This skill should be used when writing or editing Ruby code. Covers naming conventions, method design, class structure, and idiomatic Ruby patterns.
---

# Ruby Style Guide

Conventions for writing clean, idiomatic Ruby code.

## Quick Reference

| Do | Don't |
|----|-------|
| `snake_case` for methods, variables, symbols | `camelCase` or `ALLCAPS` for methods |
| `PascalCase` for classes and modules | `snake_case` for class names |
| `SCREAMING_SNAKE_CASE` for constants | `lowercase` constants |
| Suffix predicate methods with `?` | Return booleans without `?` suffix |
| Suffix dangerous methods with `!` | Use `!` without a non-bang counterpart |
| Use guard clauses for early returns | Nest conditionals deeply |
| Use `&:method` for simple transformations | Use blocks for single-method calls |
| Use string interpolation | Concatenate strings with `+` |
| Rescue specific exceptions | Rescue `Exception` or bare `rescue` |
| Freeze constant collections | Leave constant arrays/hashes mutable |
| Use implicit return | Add explicit `return` at end of method |
| Keep methods under 10 lines | Write long methods with multiple concerns |

## Naming Conventions

### Variables and Methods

Always use `snake_case` for variables, methods, and symbols. Always use `SCREAMING_SNAKE_CASE` for constants. Always use `PascalCase` for classes and modules.

```ruby
# WRONG
userName = "Alice"
def CalculateTotal; end
maxretrycount = 3

# RIGHT
user_name = "Alice"
def calculate_total; end
MAX_RETRY_COUNT = 3
DEFAULT_TIMEOUT = 30

class UserAccount; end
module PaymentProcessor; end
```

### Predicate Methods

Always suffix methods returning boolean values with `?`:

```ruby
# WRONG
def is_valid
  errors.empty?
end

def check_admin
  role == :admin
end

# RIGHT
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

Only use `!` suffix when a non-bang counterpart exists. The `!` indicates a dangerous operation (modifies receiver in place) or raises on failure (vs returning nil).

```ruby
# WRONG - no non-bang counterpart
def destroy_everything!
  # just use destroy_everything
end

# RIGHT - bang has non-bang pair
array.sort!     # sort exists
string.upcase!  # upcase exists
user.save!      # save exists (raises if invalid)
record.update!  # update exists (raises if fails)
```

## Method Design

### Guard Clauses

Use early returns to reduce nesting:

```ruby
# WRONG - deep nesting
def process_order(order)
  if order.valid?
    unless order.processed?
      order.process
      notify_customer(order)
    end
  end
end

# RIGHT - guard clauses
def process_order(order)
  return unless order.valid?
  return if order.processed?

  order.process
  notify_customer(order)
end
```

### Single Responsibility

Each method must do one thing:

```ruby
# WRONG - multiple responsibilities
def create_user_and_notify(params)
  user = User.new(params)
  if user.save
    UserMailer.welcome(user).deliver_later
    AdminNotifier.new_user(user).deliver_later
    Analytics.track(:user_created, user.id)
  end
  user
end

# RIGHT - separate concerns
def create_user(params)
  user = User.new(params)
  user.save
end

def send_welcome_email(user)
  UserMailer.welcome(user).deliver_later
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

Always prefer functional methods over loops:

```ruby
# WRONG
active_emails = []
users.each do |user|
  if user.active?
    active_emails << user.email
  end
end

# RIGHT
users.select(&:active?).map(&:email)
numbers.sum
items.any?(&:expired?)
orders.find { |o| o.total > 100 }
```

### Symbol-to-Proc

Use `&:method` for simple transformations. Use blocks only for complex logic:

```ruby
# WRONG
names.map { |n| n.upcase }
users.select { |u| u.admin? }

# RIGHT
names.map(&:upcase)
users.select(&:admin?)
numbers.reduce(&:+)

# RIGHT - block for complex logic
users.map { |u| "#{u.first_name} #{u.last_name}" }
```

### Implicit Return

Ruby returns the last expression. Use explicit `return` only for early exits:

```ruby
# WRONG
def full_name
  return "#{first_name} #{last_name}"
end

# RIGHT - implicit return
def full_name
  "#{first_name} #{last_name}"
end

# RIGHT - explicit early return
def process
  return if invalid?

  perform_action
end
```

## String Formatting

### Interpolation over Concatenation

```ruby
# WRONG
"Hello, " + user.name + "!"

# RIGHT
"Hello, #{user.name}!"
"Order ##{order.id} - #{order.status}"
```

### Heredocs for Multi-line Strings

```ruby
# WRONG
message = "Dear #{user.name},\n\nYour order has been shipped.\n\nThanks,\nThe Team"

# RIGHT
message = <<~MSG
  Dear #{user.name},

  Your order has been shipped.

  Thanks,
  The Team
MSG
```

## Error Handling

### Specific Exceptions

Always rescue specific exceptions, never generic `Exception` or `StandardError`:

```ruby
# WRONG
begin
  process_payment
rescue => e
  log_error(e)
end

# RIGHT
begin
  process_payment
rescue Stripe::CardError => e
  log_error(e)
  flash[:error] = "Payment failed: #{e.message}"
rescue Stripe::RateLimitError
  retry_later
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

Always freeze constant collections to prevent modification:

```ruby
# WRONG
VALID_STATUSES = %i[pending active completed cancelled]
DEFAULT_OPTIONS = { timeout: 30, retries: 3 }

# RIGHT
VALID_STATUSES = %i[pending active completed cancelled].freeze
DEFAULT_OPTIONS = { timeout: 30, retries: 3 }.freeze
```

### Safe Navigation

Use `&.` for potentially nil receivers:

```ruby
# WRONG
user && user.address && user.address.city

# RIGHT
user&.address&.city
```

## Common Mistakes

1. **Using `camelCase` for methods**: Ruby uses `snake_case` exclusively for methods and variables
2. **Rescuing `Exception`**: This catches `SystemExit` and `SignalException`. Always rescue specific errors or `StandardError` at most
3. **Mutable constants**: Forgetting to `.freeze` arrays and hashes assigned to constants allows accidental mutation
4. **String concatenation**: Using `+` instead of interpolation is slower and harder to read
5. **Deep nesting**: More than 2 levels of conditionals signals the need for guard clauses or method extraction
6. **Explicit return at end of method**: Ruby's implicit return makes this unnecessary noise
7. **Using `self.` unnecessarily**: Only needed for assignment (`self.name = ...`) or to disambiguate from local variables
8. **Block form for single-method calls**: Use `&:method_name` instead of `{ |x| x.method_name }`

## See Also

- `references/class-structure.md` - Complete class ordering reference with examples
