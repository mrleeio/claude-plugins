# Class Structure Reference

Standard ordering for Ruby class internals.

## Ordering Rules

Organize class contents in this order:

1. **Extend and include** - Module mixins
2. **Constants** - Class-level constants
3. **Attribute macros** - `attr_reader`, `attr_accessor`, `attr_writer`
4. **Class-level macros** - Associations, validations, callbacks, scopes
5. **Public class methods** - `def self.method_name`
6. **Public instance methods** - `def method_name`
7. **Protected methods** - After `protected` keyword
8. **Private methods** - After `private` keyword

## Complete Example

```ruby
class User < ApplicationRecord
  # 1. Extend and include
  extend Searchable
  include Authenticatable
  include Notifiable

  # 2. Constants
  ROLES = %i[admin moderator member guest].freeze
  MAX_LOGIN_ATTEMPTS = 5
  SESSION_TIMEOUT = 30.minutes

  # 3. Attribute macros
  attr_reader :token
  attr_accessor :skip_validation

  # 4. Class-level macros
  # Associations
  belongs_to :organization
  has_many :posts, dependent: :destroy
  has_many :comments
  has_one :profile

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :name, length: { maximum: 100 }
  validates :role, inclusion: { in: ROLES }

  # Callbacks
  before_validation :normalize_email
  before_save :encrypt_password, if: :password_changed?
  after_create :send_welcome_email

  # Scopes
  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: :admin) }
  scope :recent, -> { order(created_at: :desc) }

  # 5. Public class methods
  def self.find_by_email(email)
    find_by(email: email.downcase)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    user&.valid_password?(password) ? user : nil
  end

  # 6. Public instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == :admin
  end

  def can_edit?(resource)
    admin? || resource.user_id == id
  end

  # 7. Protected methods
  protected

  def generate_token
    SecureRandom.hex(20)
  end

  # 8. Private methods
  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end

  def encrypt_password
    self.password_digest = BCrypt::Password.create(password)
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
end
```

## Rails-Specific Macros Order

Within class-level macros, follow this order:

```ruby
class Post < ApplicationRecord
  # Associations (in order of relationship type)
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :likes
  has_one :featured_image
  has_and_belongs_to_many :tags

  # Validations
  validates :title, presence: true
  validates :body, length: { minimum: 100 }

  # Callbacks (in lifecycle order)
  before_validation :set_defaults
  before_save :generate_slug
  after_create :notify_followers
  after_destroy :cleanup_attachments

  # Scopes
  scope :published, -> { where(published: true) }
  scope :draft, -> { where(published: false) }
  scope :by_date, -> { order(created_at: :desc) }

  # Enums
  enum status: { draft: 0, published: 1, archived: 2 }

  # Delegations
  delegate :name, to: :user, prefix: true
  delegate :name, to: :category, prefix: true
end
```

## PORO (Plain Old Ruby Object) Example

```ruby
class PaymentProcessor
  # 1. Include modules
  include ActiveModel::Model
  include Loggable

  # 2. Constants
  SUPPORTED_CURRENCIES = %w[USD EUR GBP].freeze
  MAX_AMOUNT = 10_000_00  # cents

  # 3. Attributes
  attr_reader :amount, :currency
  attr_accessor :metadata

  # 4. Class methods
  def self.process(payment)
    new(payment).process
  end

  # 5. Initialize (special public method)
  def initialize(amount:, currency: "USD")
    @amount = amount
    @currency = currency
  end

  # 6. Public instance methods
  def process
    validate!
    charge_card
    send_receipt
  end

  def valid?
    amount.positive? && SUPPORTED_CURRENCIES.include?(currency)
  end

  # 7. Private methods
  private

  def validate!
    raise InvalidPaymentError unless valid?
  end

  def charge_card
    PaymentGateway.charge(amount: amount, currency: currency)
  end

  def send_receipt
    ReceiptMailer.payment(self).deliver_later
  end
end
```

## Quick Reference

| Section | Keywords/Patterns |
|---------|-------------------|
| Extend/Include | `extend`, `include`, `prepend` |
| Constants | `SCREAMING_SNAKE_CASE = ...` |
| Attributes | `attr_reader`, `attr_accessor`, `attr_writer` |
| Associations | `belongs_to`, `has_many`, `has_one`, `has_and_belongs_to_many` |
| Validations | `validates`, `validate` |
| Callbacks | `before_*`, `after_*`, `around_*` |
| Scopes | `scope :name, -> { ... }` |
| Class methods | `def self.method_name` |
| Instance methods | `def method_name` |
| Protected | `protected` (then methods) |
| Private | `private` (then methods) |
