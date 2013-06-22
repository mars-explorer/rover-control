
class RoverControl::InstructionsValidator
  include RoverControl::InstructionReader

  attr_reader :errors

  def initialize(instructions)
    @instructions = instructions.split("\n").map(&:strip)
    @errors = []
    validate
  end

  def valid?
    errors.empty?
  end

  private

  attr_reader :instructions

  def validate
    errors << 'invalid number of instructions' if instructions.length % 2 == 0
    errors << "invalid grid dimension (#{grid_definition})" unless grid_definition =~ /^\d+\s+\d+$/

    executions.each do |execution|
      position = execution.first
      commands = execution.last
      errors << "invalid rover position (#{position})"  unless position =~ /^\d+\s+\d+\s+[NSEW]$/
      errors << "invalid rover movements (#{commands})" unless commands =~ /^[LRM]*$/
    end
  end
end