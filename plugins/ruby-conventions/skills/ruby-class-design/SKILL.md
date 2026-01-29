---
name: ruby-class-design
description: This skill should be used when designing Ruby classes and modules. Covers SOLID principles, composition, module patterns, and object-oriented design in Ruby.
---

# Ruby Class Design

Conventions for designing well-structured Ruby classes and modules.

## SOLID Principles for Ruby

### Single Responsibility Principle (SRP)

Each class should have one reason to change:

```ruby
# Good - separate responsibilities
class Order
  def total
    line_items.sum(&:subtotal)
  end
end

class OrderPrinter
  def initialize(order)
    @order = order
  end

  def to_pdf
    # PDF generation logic
  end
end

class OrderNotifier
  def initialize(order)
    @order = order
  end

  def notify_customer
    # Email logic
  end
end

# Bad - too many responsibilities
class Order
  def total; end
  def to_pdf; end
  def send_confirmation_email; end
  def sync_to_accounting_system; end
end
```

### Open/Closed Principle (OCP)

Open for extension, closed for modification:

```ruby
# Good - extensible via new classes
class PaymentProcessor
  def process(payment)
    payment.execute
  end
end

class CreditCardPayment
  def execute
    # credit card logic
  end
end

class PayPalPayment
  def execute
    # PayPal logic
  end
end

# Bad - requires modification for each new type
class PaymentProcessor
  def process(payment)
    case payment.type
    when :credit_card
      # credit card logic
    when :paypal
      # PayPal logic
    # Must modify this class for each new payment type
    end
  end
end
```

### Liskov Substitution Principle (LSP)

Subclasses should be substitutable for their base classes:

```ruby
# Good - subtypes work as expected
class Bird
  def move
    # generic movement
  end
end

class Sparrow < Bird
  def move
    fly
  end
end

class Penguin < Bird
  def move
    walk
  end
end

# Bad - violates expectations
class Bird
  def fly
    # flying logic
  end
end

class Penguin < Bird
  def fly
    raise "Penguins can't fly!"  # Breaks LSP
  end
end
```

### Interface Segregation Principle (ISP)

Prefer small, focused interfaces:

```ruby
# Good - focused modules
module Printable
  def to_pdf; end
end

module Exportable
  def to_csv; end
  def to_json; end
end

class Report
  include Printable
  include Exportable
end

class Summary
  include Printable  # Only needs printing
end

# Bad - fat interface
module Reportable
  def to_pdf; end
  def to_csv; end
  def to_json; end
  def send_email; end
  def archive; end
end
```

### Dependency Inversion Principle (DIP)

Depend on abstractions, not concretions:

```ruby
# Good - depends on abstraction
class OrderProcessor
  def initialize(payment_gateway:, notifier:)
    @payment_gateway = payment_gateway
    @notifier = notifier
  end

  def process(order)
    @payment_gateway.charge(order.total)
    @notifier.notify(order)
  end
end

# Can inject any implementation
OrderProcessor.new(
  payment_gateway: StripeGateway.new,
  notifier: EmailNotifier.new
)

# Bad - hard-coded dependencies
class OrderProcessor
  def process(order)
    StripeGateway.new.charge(order.total)
    EmailNotifier.new.notify(order)
  end
end
```

## Composition Over Inheritance

### Favor Delegation

```ruby
# Good - composition
class ShoppingCart
  def initialize
    @items = []
    @discount_calculator = DiscountCalculator.new
  end

  def total
    subtotal = @items.sum(&:price)
    @discount_calculator.apply(subtotal)
  end
end

class DiscountCalculator
  def apply(amount)
    # discount logic
  end
end

# Avoid deep inheritance
# Bad
class Cart < BaseCart < AbstractCart < Entity
```

### When Inheritance Is Appropriate

```ruby
# Good - "is-a" relationship with shared behavior
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord
end

# Good - template method pattern
class Report
  def generate
    header + body + footer
  end

  def header
    raise NotImplementedError
  end

  def body
    raise NotImplementedError
  end

  def footer
    "Generated at #{Time.current}"
  end
end

class SalesReport < Report
  def header
    "Sales Report"
  end

  def body
    # sales data
  end
end
```

## Module Patterns

### Mixins for Shared Behavior

```ruby
module Timestamped
  def touch
    @updated_at = Time.current
  end

  def created_ago
    Time.current - @created_at
  end
end

class Article
  include Timestamped
end
```

### Concerns (Rails Pattern)

```ruby
module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, ->(term) { where("name ILIKE ?", "%#{term}%") }
  end

  class_methods do
    def searchable_columns
      [:name, :description]
    end
  end

  def matches?(term)
    searchable_columns.any? { |col| send(col).include?(term) }
  end
end

class Product < ApplicationRecord
  include Searchable
end
```

### Namespace Modules

```ruby
module Payments
  class Processor
    def process(payment)
      gateway.charge(payment)
    end
  end

  class Gateway
    def charge(payment)
      # implementation
    end
  end

  class Error < StandardError; end
  class CardDeclinedError < Error; end
end

# Usage
Payments::Processor.new.process(payment)
```

### Module as Namespace + Behavior

```ruby
module Loggable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def log_prefix
      "[#{name}]"
    end
  end

  def log(message)
    puts "#{self.class.log_prefix} #{message}"
  end
end
```

## Class Design Patterns

See `references/design-patterns.md` for detailed implementation examples.

### Value Objects

Immutable objects representing values. Use for money, dates, coordinates, etc.

Key characteristics:
- Frozen after initialization
- Equality based on attributes, not identity
- Implement `==`, `eql?`, and `hash`

### Service Objects

Encapsulate a single business operation with a `#call` method.

Key characteristics:
- Single public method (`call`)
- Dependencies injected via constructor
- Returns result or raises exception

### Query Objects

Encapsulate complex database queries.

Key characteristics:
- Initialize with base relation
- Chainable methods
- Return ActiveRecord relations

### Form Objects

Handle complex form logic separate from models.

Key characteristics:
- Include `ActiveModel::Model`
- Custom validations
- `#save` method that creates/updates records

## Constructor Patterns

### Named Parameters

```ruby
class Report
  def initialize(start_date:, end_date:, format: :pdf)
    @start_date = start_date
    @end_date = end_date
    @format = format
  end
end

Report.new(start_date: Date.today, end_date: Date.tomorrow)
```

### Builder Pattern

For objects with many optional parameters. See `references/design-patterns.md` for example.

## Summary

1. Apply SOLID principles appropriately
2. Prefer composition over deep inheritance
3. Use modules for shared behavior and namespacing
4. Create small, focused classes
5. Use value objects for immutable data
6. Extract service objects for complex operations
7. Use query objects for complex database queries
8. Use form objects for complex validations
