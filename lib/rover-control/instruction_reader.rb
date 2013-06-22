module RoverControl
  module InstructionReader

    def executions
      instructions[1..-1].each_slice(2)
    end

    def grid_definition
      instructions.first
    end
  end
end