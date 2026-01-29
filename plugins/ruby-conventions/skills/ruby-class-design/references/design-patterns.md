# Ruby Design Patterns - Detailed Examples

Extended examples of common Ruby design patterns.

## Value Objects

Immutable objects representing values:

```ruby
class Money
  attr_reader :amount, :currency

  def initialize(amount, currency = "USD")
    @amount = amount.freeze
    @currency = currency.freeze
    freeze
  end

  def +(other)
    raise ArgumentError unless currency == other.currency
    Money.new(amount + other.amount, currency)
  end

  def ==(other)
    amount == other.amount && currency == other.currency
  end
  alias eql? ==

  def hash
    [amount, currency].hash
  end

  def to_s
    "#{currency} #{format('%.2f', amount)}"
  end
end
```

## Service Objects

Encapsulate a business operation:

```ruby
class CreateOrder
  def initialize(user:, cart:, payment_method:)
    @user = user
    @cart = cart
    @payment_method = payment_method
  end

  def call
    ActiveRecord::Base.transaction do
      order = create_order
      process_payment(order)
      send_confirmation(order)
      order
    end
  end

  private

  def create_order
    Order.create!(
      user: @user,
      line_items: @cart.items,
      total: @cart.total
    )
  end

  def process_payment(order)
    PaymentProcessor.new(@payment_method).charge(order.total)
  end

  def send_confirmation(order)
    OrderMailer.confirmation(order).deliver_later
  end
end

# Usage
order = CreateOrder.new(
  user: current_user,
  cart: @cart,
  payment_method: params[:payment_method]
).call
```

## Query Objects

Encapsulate complex queries:

```ruby
class ActiveUsersQuery
  def initialize(relation = User.all)
    @relation = relation
  end

  def call
    @relation
      .where(active: true)
      .where("last_login_at > ?", 30.days.ago)
      .order(last_login_at: :desc)
  end

  def with_orders
    call.joins(:orders).distinct
  end
end

# Usage
ActiveUsersQuery.new.call
ActiveUsersQuery.new(User.where(role: :admin)).with_orders
```

## Form Objects

Handle complex form logic:

```ruby
class RegistrationForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :email, :password, :password_confirmation, :terms_accepted

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }
  validates :terms_accepted, acceptance: true

  validate :passwords_match

  def save
    return false unless valid?

    User.create!(
      email: email,
      password: password
    )
  end

  private

  def passwords_match
    return if password == password_confirmation
    errors.add(:password_confirmation, "doesn't match password")
  end
end
```

## Builder Pattern

```ruby
class QueryBuilder
  def initialize
    @conditions = []
    @order = nil
    @limit = nil
  end

  def where(condition)
    @conditions << condition
    self
  end

  def order(column)
    @order = column
    self
  end

  def limit(n)
    @limit = n
    self
  end

  def build
    # Return query object
  end
end

QueryBuilder.new
  .where(active: true)
  .where("created_at > ?", 1.week.ago)
  .order(:name)
  .limit(10)
  .build
```
