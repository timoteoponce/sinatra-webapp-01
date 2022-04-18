require_relative 'event'

class EventHandler
  attr_writer :bus

  def publish(source, msg)
    @bus.publish(Event.new(source, msg))
  end

  def handle(_event)
    raise 'Not implemented'
  end
end
