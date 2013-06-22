require 'forwardable'

class RoverControl::Rover
  extend Forwardable

  attr_reader :position, :movements, :status, :grid

  def_delegators :position, :orientation, :x, :y

  def initialize(grid, initial_position, movements)
    self.grid      = grid
    self.position  = initial_position
    self.movements = movements
  end

  def execute_next
    movement = movements.shift
    send(movement)
  end

  def execute
    while movements.any?
      execute_next
    end
  end

  private

  def spin_left
    self.position.orientation = orientation.left
  end

  def spin_right
    self.position.orientation = orientation.right
  end

  def move
    next_position = self.position.send(orientation.name)

    if is_authorized? next_position
      self.position = next_position
    else
      puts "authorization denied #{authorization(position)}"
      stop authorization(next_position).reason
    end
  end

  def is_authorized?(position)
    authorization(position).granted?
  end

  def authorization(position)
    grid.authorize_movement?(position)
  end

  def stop(reason)
    self.movements = []
    puts "setting status, #{reason.inspect}"
    self.status = reason
  end

  attr_writer :position, :movements, :grid, :status
end