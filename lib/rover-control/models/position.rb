
class Position < Point
  attr_accessor :orientation

  def initialize(x=0, y=0, orientation= :north)
    super x,y
    self.orientation = orientation
  end
end