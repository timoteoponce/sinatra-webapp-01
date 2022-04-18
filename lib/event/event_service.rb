class EventService
  def initialize
    @listeners = []
    @publishers = []
  end

  def add_listener(listener)
    @listeners = @listeners << listener
  end

  def add_publisher(publisher)
    publisher.bus = self
    @publishers = @publishers << publisher
  end

  def publish(event)
    @listeners.each { |h| h.handle(event) }
  end
end
