
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
    parsed = instruction_parser_class.new(instructions).parse
    env = environment_builder.build(parsed)
    out = env.rovers.map { |rover| rover.execute ; output_builder_class.new(rover) }
    out.each { |b| output.puts b.build }
  end

  private

  attr_accessor :output, :instruction_parser_class, :environment_builder, :output_builder_class

end