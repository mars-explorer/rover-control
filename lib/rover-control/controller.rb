
class RoverControl::Controller

  def initialize(output = $stdout, instruction_parser_class = RoverControl::InstructionsParser,
                                   environment_builder      = RoverControl::EnviromentBuilder.new,
                                   output_builder_class     = RoverControl::RoverOutputBuilder)
    self.output = output

    self.instruction_parser_class  = instruction_parser_class
    self.environment_builder        = environment_builder
    self.output_builder_class      = output_builder_class
  end

  def execute(instructions)
    validator = RoverControl::InstructionsValidator.new(instructions)
    unless validator.valid?
      output.puts validator.errors.join("\n")
      return
    end

    env = build_environment_from instructions
    out = env.rovers.map { |rover| rover.execute ; output_builder_class.new(rover) }
    out.each { |b| output.puts b.build }
  end

  private

  attr_accessor :output, :instruction_parser_class, :environment_builder, :output_builder_class

  def build_environment_from instructions
    parsed = instruction_parser_class.new(instructions).parse
    environment_builder.build(parsed)
  end

end