# frozen_string_literal: true

# Base concern template for tenant-scoped models
# Include in any model that belongs to an account for automatic scoping
#
# Usage:
#   class Card < ApplicationRecord
#     include TenantScoped
#   end

module TenantScoped
  extend ActiveSupport::Concern

  included do
    belongs_to :account

    default_scope { where(account: Current.account) if Current.account }
  end

  class_methods do
    # Query without tenant scoping (use carefully!)
    def unscoped_for_tenant
      unscope(where: :account_id)
    end
  end
end
