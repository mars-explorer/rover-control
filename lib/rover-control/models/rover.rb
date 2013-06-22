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

  CARDINALS = [:north, :west, :south, :east]

  def spin_left
    self.position.orientation = CARDINALS[ (CARDINALS.index(orientation) + 1) % 4 ]
  end

  def spin_right
    self.position.orientation = CARDINALS[ (CARDINALS.index(orientation) - 1) % 4 ]
  end

  def move
    case self.position.orientation
    when :north
      self.position.y = self.position.y + 1
    when :south
      self.position.y = self.position.y - 1
    when :west
      self.position.x = self.position.x - 1
    when :east
      self.position.x = self.position.x + 1
    end
  end

  attr_writer :position, :movements
end