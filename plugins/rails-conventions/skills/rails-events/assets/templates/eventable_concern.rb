# Template: Eventable Concern
# Copy to app/models/concerns/eventable.rb

module Eventable
  extend ActiveSupport::Concern

  included do
    has_many :events, as: :eventable, dependent: :destroy
  end

  def track_event(action, creator: Current.user, **particulars)
    events.create!(
      account: account,
      creator: creator,
      action: action,
      particulars: particulars
    )
  end
end
