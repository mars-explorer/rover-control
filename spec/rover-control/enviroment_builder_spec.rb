require 'spec_helper'
require 'rover-control/enviroment_builder'

describe RoverControl::EnviromentBuilder do
  subject { described_class.new }

  describe '#build' do
    let(:fixture) do
      {
        grid: { width: 6, height: 7 },
        execution_plan: [
          {
            initial_position: { x: 1, y: 2, orientation: :north },
            movements: [:spin_left, :move, :spin_left, :move ]
          },
          {
            initial_position: { x: 4, y: 4, orientation: :north },
            movements: [:spin_left, :move ]
          }
        ]
      }
    end

    subject { described_class.new.build(fixture) }

    its(:grid)   { should == Grid.new(6,7) }
    its(:rovers) { should have(2).items }

    describe 'rover' do
      let(:rover) { subject.rovers.first }

      it 'initialize the rover with its initial position' do
        expect(rover.position).to eq(Position.new(1,2,:north))
      end

      it 'initialize the rover with its movements' do
        expect(rover.movements).to eq([:spin_left, :move, :spin_left, :move ])
      end
    end
  end
end