# frozen_string_literal: true

require "test_helper"

class ClassNameTest < ActiveSupport::TestCase
  setup do
    @instance = ClassName.new(attribute: value)
  end

  # === Class Methods ===
  test ".class_method_name returns expected result when condition is met" do
    result = ClassName.class_method_name(arg)
    assert_equal expected, result
  end

  test ".class_method_name returns nil when condition is not met" do
    result = ClassName.class_method_name(nil)
    assert_nil result
  end

  # === Instance Methods ===
  test "#instance_method_name performs expected behavior with valid input" do
    result = @instance.instance_method_name("valid")
    assert_equal expected, result
  end

  test "#instance_method_name raises ArgumentError with invalid input" do
    assert_raises(ArgumentError) do
      @instance.instance_method_name(nil)
    end
  end

  # === Edge Cases ===
  test "#instance_method_name handles empty input" do
    result = @instance.instance_method_name("")
    assert_equal default_value, result
  end
end
