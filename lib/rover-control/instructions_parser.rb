
class RoverControl::InstructionsParser
  include RoverControl::InstructionReader

  def initialize(instructions)
    self.instructions = instructions.split("\n")
  end

  def parse
    {
      grid: parse_grid,
      execution_plan: parse_executions
    }
  end

  private

  attr_accessor :instructions

  def parse_grid
    {
      width:  Integer(grid.first),
      height: Integer(grid.last)
    }
  end

  def parse_executions
    executions.map { |execution| parse_one_execution(execution) }
  end

  def parse_one_execution(execution)
    position = execution.first
    movements = execution.last

    {
      initial_position: parse_position(position),
      movements: parse_movements(movements)
    }
  end

  def grid
    grid_definition.split ' '
  end

  def parse_position(position)
    coordinates = position.split ' '
    {
      x: Integer(coordinates[0]),
      y: Integer(coordinates[1]),
      orientation: parse_orientation(coordinates[2])
    }
  end

  def parse_movements(movements)
    movements.strip.chars.map do |char|
      case(char)
      when 'L' then :spin_left
      when 'R' then :spin_right
      when 'M' then :move
      end
    end
  end

  def parse_orientation(orientation)
    case(orientation)
    when 'N' then CardinalDirection.north
    when 'S' then CardinalDirection.south
    when 'E' then CardinalDirection.east
    when 'W' then CardinalDirection.west
    end
  end
end