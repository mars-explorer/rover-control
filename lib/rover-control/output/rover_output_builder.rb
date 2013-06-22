
class RoverControl::RoverOutputBuilder

  def initialize(rover)
    self.rover = rover
  end

  def build
    "#{rover.x} #{rover.y} #{orientation}#{message}"
  end

  private

  attr_accessor :rover

  def orientation
    case rover.orientation
    when CardinalDirection.north then 'N'
    when CardinalDirection.south then 'S'
    when CardinalDirection.east  then 'E'
    when CardinalDirection.west  then 'W'
    end
  end

  def message
    " (#{rover.status})" if rover.status
  end
end