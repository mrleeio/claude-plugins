# frozen_string_literal: true

require "rails_helper"

RSpec.describe ClassName do
  # === Test Data ===
  let(:instance) { described_class.new(attribute: value) }

  # === Class Methods ===
  describe ".class_method_name" do
    context "when condition is met" do
      it "returns expected result" do
        result = described_class.class_method_name(arg)
        expect(result).to eq(expected)
      end
    end

    context "when condition is not met" do
      it "returns nil" do
        result = described_class.class_method_name(nil)
        expect(result).to be_nil
      end
    end
  end

  # === Instance Methods ===
  describe "#instance_method_name" do
    context "when valid input" do
      it "performs expected behavior" do
        # Arrange
        input = "valid"

        # Act
        result = instance.instance_method_name(input)

        # Assert
        expect(result).to eq(expected)
      end
    end

    context "when invalid input" do
      it "raises ArgumentError" do
        expect {
          instance.instance_method_name(nil)
        }.to raise_error(ArgumentError)
      end
    end
  end

  # === Edge Cases ===
  describe "edge cases" do
    it "handles empty input" do
      result = instance.instance_method_name("")
      expect(result).to eq(default_value)
    end
  end
end
