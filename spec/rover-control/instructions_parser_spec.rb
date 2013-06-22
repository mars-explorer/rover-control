require 'spec_helper'
require 'rover-control/instructions_parser'

describe RoverControl::InstructionsParser do
  subject { described_class.new(instructions) }

  describe '#instructions' do
    let(:instructions) { "5 5\n1 2 N\nLMLMLMRMM" }
    let(:parsed) { subject.parse }

    describe 'grid' do
      let(:grid) { parsed[:grid] }

      it 'parses the grid size' do
        expect(grid).to eq({width: 5, height: 5})
      end

      context 'rectangular grid' do
        let(:instructions) { "5 6\n" }

        it 'parses correctly the with and the height' do
          expect(grid).to eq({width: 5, height: 6})
        end
      end

      describe 'supports extra spaces' do
        let(:instructions) { "    5   6   \n" }

        it 'parses correctly the with and the height' do
          expect(grid).to eq({width: 5, height: 6})
        end
      end
    end

    describe 'the execution plan' do
      let(:execution_plan) { parsed[:execution_plan] }
      let(:first_execution) { execution_plan.first }

      it 'builds an execution plan' do
        expect(execution_plan.size).to equal(1)
      end

      describe 'initial position' do
        let(:position) { first_execution[:initial_position] }

        it 'sets the initial position lattitude' do
          expect(position[:x]).to equal(1)
        end

        it 'sets the initial position longitude' do
          expect(position[:y]).to equal(2)
        end

        describe 'orientation' do
          it 'sets the initial position orientation' do
            expect(position[:orientation]).to equal(:north)
          end

          describe 'south orientation' do
            let(:instructions) { "5 5\n1 2 S\nL" }

            specify { expect(position[:orientation]).to equal(:south) }
          end

          describe 'east orientation' do
            let(:instructions) { "5 5\n1 2 E\nL" }

            specify { expect(position[:orientation]).to equal(:east) }
          end

          describe 'west orientation' do
            let(:instructions) { "5 5\n1 2 W\nL" }

            specify { expect(position[:orientation]).to equal(:west) }
          end

          describe 'supports extra spaces' do
            let(:instructions) { "5 5\n   1   2   W   \nL" }

            it 'sets the initial position lattitude' do
              expect(position[:x]).to equal(1)
            end

            it 'sets the initial position longitude' do
              expect(position[:y]).to equal(2)
            end

            it 'parses correctly the with and the height' do
              expect(position[:orientation]).to equal(:west)
            end
          end
        end
      end

      describe 'movements' do
        let(:movements) { first_execution[:movements] }

        it 'parses the second line as the movements' do
          expect(movements).to eq([:spin_left, :move, :spin_left, :move, :spin_left, :move, :spin_right, :move, :move])
        end

        describe 'supports extra spaces' do
          let(:instructions) { "5 5\n1 2 N\n    LMLMLMRMM " }

          it 'parses correctly the with and the height' do
            expect(movements).to eq([:spin_left, :move, :spin_left, :move, :spin_left, :move, :spin_right, :move, :move])
          end
        end
      end
    end
  end
end