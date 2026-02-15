# frozen_string_literal: true

# Service Object Template
# Encapsulates a single business operation. Stateless with injected dependencies.
#
# Usage:
#   result = ProcessOrder.new(payment_gateway: StripeGateway.new).call(order)

class ServiceObjectName
  def initialize(dependency_one:, dependency_two:)
    @dependency_one = dependency_one
    @dependency_two = dependency_two
  end

  def call(input)
    validate(input)
    result = perform(input)
    notify(result)
    result
  end

  private

  attr_reader :dependency_one, :dependency_two

  def validate(input)
    raise ArgumentError, "Input is required" if input.nil?
  end

  def perform(input)
    # Core business logic here
  end

  def notify(result)
    # Side effects (notifications, logging, etc.)
  end
end
