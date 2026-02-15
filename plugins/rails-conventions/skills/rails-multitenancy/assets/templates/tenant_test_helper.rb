# frozen_string_literal: true

# Test helper template for multi-tenancy
# Sets up tenant context for integration and system tests
#
# Usage in test_helper.rb:
#   include TenantTestHelper

module TenantTestHelper
  extend ActiveSupport::Concern

  included do
    setup do
      set_tenant_context(accounts(:default))
    end

    teardown do
      Current.clear_all
    end
  end

  private

  def set_tenant_context(account)
    Current.account = account

    if respond_to?(:integration_session)
      integration_session.default_url_options[:script_name] = "/#{account.external_account_id}"
    elsif respond_to?(:default_url_options)
      self.default_url_options[:script_name] = "/#{account.external_account_id}"
    end
  end

  def untenanted
    original_script_name = if respond_to?(:integration_session)
      integration_session.default_url_options[:script_name]
    end

    if respond_to?(:integration_session)
      integration_session.default_url_options[:script_name] = ""
    end

    yield
  ensure
    if respond_to?(:integration_session)
      integration_session.default_url_options[:script_name] = original_script_name
    end
  end
end
