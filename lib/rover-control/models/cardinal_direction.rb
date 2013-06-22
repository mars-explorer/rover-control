
class CardinalDirection
  attr_reader :name

  def left
    left_name = DIRECTIONS[ (DIRECTIONS.index(name) + 1) % 4 ]

    self.class.send left_name
  end

  def right
    right_name = DIRECTIONS[ (DIRECTIONS.index(name) - 1) % 4 ]

    self.class.send right_name
  end

  private

  DIRECTIONS = [:north, :west, :south, :east]

  def initialize(name)
    @name = name
  end

  def self.north
    @north ||= CardinalDirection.new(:north)
  end

  def self.south
    @south ||= CardinalDirection.new(:south)
  end

  def self.east
    @east ||= CardinalDirection.new(:east)
  end

  def self.west
    @west ||= CardinalDirection.new(:west)
  end
end