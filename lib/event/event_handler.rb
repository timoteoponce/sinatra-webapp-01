require_relative 'event'

# listener - listen/read events
# publisher - publish/emit events

class EventPublisher
  attr_writer :bus

  def publish(source, msg)
    @bus.publish(Event.new(source, msg))
  end
end

class EventListener
  def handle(_event)
    raise 'Not implemented'
  end
end
