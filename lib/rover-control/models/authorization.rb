
class RoverControl::Authorization

  attr_reader :granted, :reason

  def self.granted
    new(true)
  end

  def self.denied(reason)
    new(false, reason)
  end

  def granted?
    granted
  end

  private

  def initialize(granted, reason = nil)
    @granted = granted
    @reason  = reason
  end
end