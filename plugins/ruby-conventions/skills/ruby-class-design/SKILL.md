---
name: ruby-class-design
description: This skill should be used when designing Ruby classes and modules. Covers SOLID principles, composition, module patterns, and object-oriented design in Ruby.
---

# Ruby Class Design

Prefer composition over inheritance. Inject dependencies. Keep classes focused on one responsibility.

## Quick Reference

| Do | Don't |
|----|-------|
| Compose objects via delegation | Build deep inheritance hierarchies |
| Inject dependencies via constructor | Hard-code dependencies inside methods |
| Keep classes focused on one responsibility | Give classes multiple reasons to change |
| Use small, focused modules for shared behavior | Create fat modules with unrelated methods |
| Use named parameters for constructors | Use positional arguments for >2 params |
| Create value objects for immutable data | Pass raw hashes for structured data |
| Use service objects for single operations | Put multi-step logic in controllers |
| Depend on abstractions (duck typing) | Depend on concrete classes |

## Core Rules

```ruby
# WRONG - deep inheritance, hard-coded dependencies, multiple responsibilities
class Order < BaseOrder < AbstractOrder < Entity
  def process
    StripeGateway.new.charge(total)
    EmailNotifier.new.notify(self)
    PdfGenerator.new.generate_invoice(self)
  end
end

# RIGHT - composition, injected dependencies, single responsibility
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

OrderProcessor.new(
  payment_gateway: StripeGateway.new,
  notifier: EmailNotifier.new
)
```

## SOLID Principles

### Single Responsibility Principle (SRP)

Give each class one reason to change:

```ruby
# WRONG - too many responsibilities
class Order
  def total; end
  def to_pdf; end
  def send_confirmation_email; end
  def sync_to_accounting_system; end
end

# RIGHT - separate responsibilities
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
```

### Open/Closed Principle (OCP)

Design classes to be extended without modification:

```ruby
# WRONG - requires modification for each new type
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

# RIGHT - extensible via new classes
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
```

### Liskov Substitution Principle (LSP)

Ensure subclasses are substitutable for their base classes:

```ruby
# WRONG - violates expectations
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

# RIGHT - subtypes work as expected
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
```

### Interface Segregation Principle (ISP)

Use small, focused modules instead of fat interfaces:

```ruby
# WRONG - fat interface
module Reportable
  def to_pdf; end
  def to_csv; end
  def to_json; end
  def send_email; end
  def archive; end
end

# RIGHT - focused modules
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
```

### Dependency Inversion Principle (DIP)

Depend on abstractions (duck typing), not concrete classes:

```ruby
# WRONG - hard-coded dependencies
class OrderProcessor
  def process(order)
    StripeGateway.new.charge(order.total)
    EmailNotifier.new.notify(order)
  end
end

# RIGHT - depends on abstraction
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
```

## Composition Over Inheritance

### Favor Delegation

```ruby
# WRONG - deep inheritance
class Cart < BaseCart < AbstractCart < Entity

# RIGHT - composition
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
```

### When Inheritance Is Appropriate

Use inheritance only for true "is-a" relationships with shared behavior:

```ruby
# RIGHT - "is-a" relationship with shared behavior
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class User < ApplicationRecord
end

# RIGHT - template method pattern
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

Use modules to share behavior across unrelated classes:

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

Use modules for logical grouping:

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

## Class Design Patterns

See `references/design-patterns.md` for detailed implementation examples and templates in `assets/templates/`.

### Value Objects

Create immutable objects for structured data. Freeze after initialization. Implement equality based on attributes.

### Service Objects

Encapsulate a single business operation with a `#call` method. Inject dependencies via constructor. Return a result or raise an exception.

### Query Objects

Encapsulate complex database queries. Initialize with a base relation. Return ActiveRecord relations for chaining.

### Form Objects

Handle complex form logic separate from models. Include `ActiveModel::Model`. Implement `#save` that creates/updates records.

## Constructor Patterns

### Named Parameters

Always use named parameters when a method takes more than 2 arguments:

```ruby
# WRONG
Report.new(Date.today, Date.tomorrow, :pdf, true)

# RIGHT
class Report
  def initialize(start_date:, end_date:, format: :pdf)
    @start_date = start_date
    @end_date = end_date
    @format = format
  end
end

Report.new(start_date: Date.today, end_date: Date.tomorrow)
```

## Common Mistakes

1. **Deep inheritance hierarchies**: More than 2 levels deep signals the need for composition. Prefer delegation over `super` chains
2. **God classes**: Classes with too many methods or instance variables. Split into focused collaborators
3. **Hard-coded dependencies**: Instantiating collaborators inside methods prevents testing and reuse. Inject via constructor
4. **Fat modules**: Including a module that adds 10+ methods couples classes to unrelated behavior. Keep modules focused
5. **Positional constructor arguments**: `User.new("Alice", 30, true)` is unreadable. Use keyword arguments
6. **Mutable value objects**: Forgetting to freeze value objects allows corruption. Always `freeze` in `initialize`
7. **Missing duck typing**: Checking `is_a?` instead of responding to a method. Use `respond_to?` or trust the interface
8. **Service objects with state**: Service objects should be stateless. Pass data through `#call`, not through instance variables that persist

## See Also

- `references/design-patterns.md` - Value objects, service objects, query objects, form objects
- `assets/templates/` - Scaffolding templates for common patterns
