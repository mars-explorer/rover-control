
class RoverControl::EnviromentBuilder

  def build(instructions)
    enviroment = RoverControl::Enviroment.new

    enviroment.grid = Grid.new(instructions[:grid][:width], instructions[:grid][:height])
    enviroment.rovers = instructions[:execution_plan].map do |execution|
      position = Position.new(execution[:initial_position][:x],
                              execution[:initial_position][:y],
                              execution[:initial_position][:orientation])
      RoverControl::Rover.new(enviroment.grid, position, execution[:movements])
    end

    enviroment
  end


  private

  class RoverControl::Enviroment
    attr_accessor :grid, :rovers
  end
end