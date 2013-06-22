
class RoverControl::Controller

  def initialize(output = $stdout)
    self.output = output
  end

  def execute(instructions)
  end

  private

  attr_accessor :output

end