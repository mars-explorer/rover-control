
class RoverControl::Rover
  attr_reader :position, :movements

  def initialize(initial_position, movements)
    self.position  = initial_position
    self.movements = movements
  end

  private

  attr_writer :position, :movements
end