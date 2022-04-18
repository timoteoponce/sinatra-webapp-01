class EventLogger < EventHandler
  def handle(event)
    puts "#{event.date} - [#{event.id}] : #{event.source} > #{event.message}"
  end
end
