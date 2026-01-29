# Template: Base Notifier Class
# Copy this file to app/models/notifier.rb

class Notifier
  attr_reader :source

  class << self
    def for(source)
      # Route to specific notifier based on source type
      # Add cases here as you create new notifiers
      case source
      when Event
        notifier_for_event(source)
      # when Mention
      #   MentionNotifier.new(source)
      end
    end

    private
      def notifier_for_event(event)
        "Notifier::#{event.eventable.class}EventNotifier".safe_constantize&.new(event)
      end
  end

  def notify
    if should_notify?
      recipients.sort_by(&:id).each do |recipient|
        Notification.create!(
          account: source.account,
          user: recipient,
          source: source,
          creator: creator
        )
      end
    end
  end

  private
    def initialize(source)
      @source = source
    end

    def should_notify?
      !creator.system?
    end

    # Override in subclasses
    def creator
      raise NotImplementedError, "#{self.class} must implement #creator"
    end

    # Override in subclasses
    def recipients
      raise NotImplementedError, "#{self.class} must implement #recipients"
    end
end
