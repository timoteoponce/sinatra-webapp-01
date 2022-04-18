require 'securerandom'
require 'date'

class Event
  attr_accessor :id, :date, :source, :message

  def initialize(source, message)
    @id = SecureRandom.uuid.to_s
    @date = DateTime.now
    @source = source
    @message = message
  end

  def to_s
    "{:id '#{@id}' :date '#{@date}' :source '#{@source}' :message '#{@message}'}"
  end
end
