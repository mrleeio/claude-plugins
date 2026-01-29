# Template: Notifiable Concern
# Copy this file to app/models/concerns/notifiable.rb

module Notifiable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :source, dependent: :destroy
    after_create_commit :notify_later
  end

  def notify_later
    Notifiable::NotifyJob.perform_later(self)
  end

  def notify_now
    Notifier.for(self)&.notify
  end
end

# Also create the job:
# app/jobs/notifiable/notify_job.rb
#
# class Notifiable::NotifyJob < ApplicationJob
#   def perform(source)
#     source.notify_now
#   end
# end
