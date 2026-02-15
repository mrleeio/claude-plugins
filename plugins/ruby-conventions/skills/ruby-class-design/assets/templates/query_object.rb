# frozen_string_literal: true

# Query Object Template
# Encapsulates complex database queries. Returns ActiveRecord relations for chaining.
#
# Usage:
#   ActiveUsersQuery.new(User.all).call(since: 30.days.ago)

class QueryObjectName
  def initialize(relation = ModelName.all)
    @relation = relation
  end

  def call(**filters)
    result = @relation
    result = apply_filter_one(result, filters[:filter_one]) if filters[:filter_one]
    result = apply_filter_two(result, filters[:filter_two]) if filters[:filter_two]
    result = apply_ordering(result)
    result
  end

  private

  def apply_filter_one(relation, value)
    relation.where(column_name: value)
  end

  def apply_filter_two(relation, value)
    relation.where("column_name >= ?", value)
  end

  def apply_ordering(relation)
    relation.order(created_at: :desc)
  end
end
