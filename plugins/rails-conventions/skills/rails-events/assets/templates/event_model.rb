# Template: Event Model
# Copy to app/models/event.rb

class Event < ApplicationRecord
  include Event::Relaying

  belongs_to :account
  belongs_to :creator, class_name: "User", default: -> { Current.user }
  belongs_to :eventable, polymorphic: true

  serialize :particulars, coder: JSON

  after_create_commit :relay_later
  after_create_commit :notify_later

  scope :recent, -> { order(created_at: :desc) }
  scope :for_eventable, ->(eventable) { where(eventable: eventable) }

  private
    def relay_later
      Event::RelayJob.perform_later(self)
    end

    def notify_later
      Event::NotifyJob.perform_later(self)
    end
end
