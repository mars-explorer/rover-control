
class Grid

  attr_accessor :width, :height, :rovers

  def initialize(width = 0, height = 0)
    self.width = width
    self.height = height
  end

  def register_rovers(rovers)
    self.rovers = rovers
  end

  def ==(other)
    width  == other.width  &&
    height == other.height
  end

  def authorize_movement?(destination)
    return RoverControl::Authorization.denied('stopped to not exist the grid') unless position_in_the_grid?(destination)
    return RoverControl::Authorization.denied('stopped to avoid a collision')  if rover_already_at?(destination)

    RoverControl::Authorization.granted
  end

  private

  def position_in_the_grid?(position)
    position.x >= 0 &&
    position.x <= width &&
    position.y >= 0 &&
    position.y <= height
  end

  def rover_already_at?(destination)
    rovers.map { |rover| rover.position.to_point }.include? destination.to_point
  end
end