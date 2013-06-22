
class Position < Point
  attr_accessor :orientation

  def initialize(x=0, y=0, orientation= :north)
    super x,y
    self.orientation = orientation
  end

  def ==(other)
    super &&
    orientation == other.orientation
  end

  def north
    orient super()
  end

  def south
    orient super()
  end

  def east
   orient super()
  end

  def west
    orient super()
  end

  def to_point
    Point.new(x,y)
  end

  private

  def orient(position)
    position.orientation = orientation
    position
  end
end