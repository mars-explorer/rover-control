
class RoverControl::RoverOutputBuilder

  def initialize(rover)
    self.rover = rover
  end

  def build
    "#{rover.x} #{rover.y} #{orientation}"
  end

  private

  attr_accessor :rover

  def orientation
    case rover.orientation
    when :north then 'N'
    when :south then 'S'
    when :east  then 'E'
    when :west  then 'W'
    end
  end
end