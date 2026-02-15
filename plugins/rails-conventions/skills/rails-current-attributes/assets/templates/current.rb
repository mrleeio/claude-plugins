# frozen_string_literal: true

# Current model template
# Manages request-scoped state via CurrentAttributes
#
# Usage:
#   Current.account = account
#   Current.user    # => cascaded from session

class Current < ActiveSupport::CurrentAttributes
  attribute :account, :session

  # Cascading setter: setting session automatically sets identity and user
  def session=(session)
    super
    self.identity = session&.identity
  end

  def identity=(identity)
    @identity = identity
    self.user = identity&.user_for(account)
  end

  def identity
    @identity
  end

  def user=(user)
    @user = user
  end

  def user
    @user || account&.system_user
  end

  # Block helper for temporary account context
  def with_account(account)
    previous_account = self.account
    self.account = account
    yield
  ensure
    self.account = previous_account
  end
end
