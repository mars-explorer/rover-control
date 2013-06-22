
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

  def authorize_movement?(destination)
    return RoverControl::Authorization.denied('stopped to not exist the grid') unless position_in_the_grid?(destination)

    RoverControl::Authorization.granted
  end

  private

  def position_in_the_grid?(position)
    position.x >= 0 &&
    position.x <= width &&
    position.y >= 0 &&
    position.y <= height
  end
end