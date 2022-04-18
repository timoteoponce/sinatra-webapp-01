class EventService
  def initialize
    @handlers = []
  end

  def add_handler(handler)
    handler.bus = self
    @handlers = @handlers << handler
  end

  def publish(event)
    @handlers.each { |h| h.handle(event) }
  end
end
