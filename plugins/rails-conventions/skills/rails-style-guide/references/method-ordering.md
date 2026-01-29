# Method Ordering

Organize methods in a consistent, readable order.

## Class Structure

1. Class methods
2. Public methods (with `initialize` first)
3. Private methods

```ruby
class Card
  def self.recent
    order(created_at: :desc)
  end

  def initialize(attributes = {})
    super
  end

  def close
    # ...
  end

  def reopen
    # ...
  end

  private
    def track_closure
      # ...
    end
end
```

## Invocation Order

Order private methods by their invocation order in public methods:

```ruby
class SomeClass
  def some_method
    method_1
    method_2
  end

  private
    def method_1
      method_1_1
      method_1_2
    end

    def method_1_1
      # ...
    end

    def method_1_2
      # ...
    end

    def method_2
      method_2_1
      method_2_2
    end

    def method_2_1
      # ...
    end

    def method_2_2
      # ...
    end
end
```

## Why Invocation Order?

Reading code top-to-bottom follows the execution flow:
1. See public method calls `method_1`
2. Find `method_1` immediately below
3. See `method_1` calls `method_1_1` and `method_1_2`
4. Find those methods immediately below

## Rails Model Conventions

```ruby
class Card < ApplicationRecord
  # 1. Concerns
  include Eventable
  include Card::Closeable

  # 2. Constants
  STATUSES = %w[draft published archived].freeze

  # 3. Associations
  belongs_to :account
  belongs_to :creator, class_name: "User"
  has_many :comments, dependent: :destroy

  # 4. Validations
  validates :title, presence: true

  # 5. Callbacks
  after_create_commit :notify_watchers

  # 6. Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :published, -> { where(status: :published) }

  # 7. Class methods
  def self.search(query)
    where("title ILIKE ?", "%#{query}%")
  end

  # 8. Instance methods
  def publish
    update!(status: :published, published_at: Time.current)
  end

  private
    def notify_watchers
      # ...
    end
end
```

## Rails Controller Conventions

```ruby
class CardsController < ApplicationController
  # 1. Callbacks
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # 2. Actions in CRUD order
  def index
    @cards = Current.account.cards.recent
  end

  def show
  end

  def new
    @card = Card.new
  end

  def create
    @card = Current.account.cards.create!(card_params)
    redirect_to @card
  end

  def edit
  end

  def update
    @card.update!(card_params)
    redirect_to @card
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private
    def set_card
      @card = Current.account.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:title, :description)
    end
end
```
