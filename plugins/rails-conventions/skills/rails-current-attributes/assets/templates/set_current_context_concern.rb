# frozen_string_literal: true

# Controller concern template for setting Current context
# Include in ApplicationController to set account and session on every request
#
# Usage:
#   class ApplicationController < ActionController::Base
#     include SetCurrentContext
#   end

module SetCurrentContext
  extend ActiveSupport::Concern

  included do
    before_action :set_current_account
    before_action :set_current_session
  end

  private

  def set_current_account
    Current.account = Account.find_by!(external_id: params[:account_id])
  end

  def set_current_session
    Current.session = Session.find_by(token: cookies.signed[:session_token])
  end
end
