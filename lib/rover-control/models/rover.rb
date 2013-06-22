require 'forwardable'

class RoverControl::Rover
  extend Forwardable

  attr_reader :position, :movements
  def_delegators :position, :orientation, :x, :y

  def initialize(initial_position, movements)
    self.position  = initial_position
    self.movements = movements
  end

  def execute_next
    movement = movements.shift
    send(movement)
  end

  def execute
    begin
      execute_next
    end while movements.any?
  end

  private

  def spin_left
    self.position.orientation = orientation.left
  end

  def spin_right
    self.position.orientation = orientation.right
  end

  def move
    self.position = self.position.send(orientation.name)
  end

  attr_writer :position, :movements
end