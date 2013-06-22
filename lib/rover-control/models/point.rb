
class Point
  attr_accessor :x, :y

  def initialize(x=0, y=0)
    self.x = x
    self.y = y
  end

  def ==(other)
    x == other.x &&
    y == other.y
  end
end