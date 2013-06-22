
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

  def north
    self.class.new(x, y+1)
  end

  def south
    self.class.new(x, y-1)
  end

  def east
    self.class.new(x+1, y)
  end

  def west
    self.class.new(x-1, y)
  end
end