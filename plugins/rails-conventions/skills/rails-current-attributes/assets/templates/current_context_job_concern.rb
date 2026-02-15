# frozen_string_literal: true

# Job concern template for preserving Current context in background jobs
# Include in ApplicationJob to serialize and restore Current.account
#
# Usage:
#   class ApplicationJob < ActiveJob::Base
#     include CurrentContextJob
#   end

module CurrentContextJob
  extend ActiveSupport::Concern

  included do
    attr_accessor :current_account_id

    before_enqueue do |job|
      job.current_account_id = Current.account&.id
    end

    before_perform do |job|
      if job.current_account_id
        Current.account = Account.find(job.current_account_id)
      end
    end

    after_perform do
      Current.clear_all
    end
  end
end
