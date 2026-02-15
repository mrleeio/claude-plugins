# frozen_string_literal: true

# Value Object Template
# Immutable object representing a value. Use for money, coordinates, date ranges, etc.
#
# Usage:
#   money = Money.new(amount: 100, currency: "USD")
#   money.amount  # => 100
#   money == Money.new(amount: 100, currency: "USD")  # => true

class ValueObjectName
  attr_reader :attribute_one, :attribute_two

  def initialize(attribute_one:, attribute_two:)
    @attribute_one = attribute_one
    @attribute_two = attribute_two
    freeze
  end

  def ==(other)
    other.is_a?(self.class) &&
      attribute_one == other.attribute_one &&
      attribute_two == other.attribute_two
  end
  alias eql? ==

  def hash
    [self.class, attribute_one, attribute_two].hash
  end

  def to_s
    "#{attribute_one} #{attribute_two}"
  end
end
