
class Grid

  attr_accessor :width, :height

  def initialize(width = 0, height = 0)
    self.width = width
    self.height = height
  end

  def ==(other)
    width  == other.width  &&
    height == other.height
  end
end