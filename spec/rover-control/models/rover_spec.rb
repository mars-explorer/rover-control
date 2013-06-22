require 'spec_helper'
require 'rover-control/models/rover'

shared_examples_for 'to be located at' do |expected_x, expected_y, expected_orientation|
  specify { expect(subject.position.x).to eq(expected_x) }
  specify { expect(subject.position.y).to eq(expected_y) }
  specify { expect(subject.position.orientation).to eq(CardinalDirection.send(expected_orientation)) }
end

describe RoverControl::Rover do
  let(:x)                { 1 }
  let(:y)                { 1 }
  let(:orientation)      { CardinalDirection.north}
  let(:initial_position) { Position.new(x, y, orientation) }
  let(:movements)        { [:spin_right] }
  let(:grid)             { stub :grid, authorize_movement?: RoverControl::Authorization.granted }

  subject { described_class.new grid, initial_position, movements }

  describe '#initialize' do
    its(:position)  { should == initial_position }
    its(:movements) { should == movements }
  end

  describe 'forwarded methods to the position' do
    its(:orientation) { should == orientation }
    its(:x)           { should == x }
    its(:y)           { should == y }
  end
  describe 'execute_next' do
    let(:movements) { [:spin_left, :spin_right] }

    before do
      subject.execute_next
    end

    it 'removes the movement when done' do
      expect(subject.movements).to eq([:spin_right])
    end

    describe 'spin_left' do
      let(:movements) { [ :spin_left ] }

      it 'change sits orientation' do
        expect(subject.orientation).to equal(CardinalDirection.west)
      end
    end

    describe 'spin_right' do
      let(:movements) { [ :spin_right ] }

      it 'changes its orientation' do
        expect(subject.orientation).to equal(CardinalDirection.east)
      end
    end

    describe 'move' do
      let(:movements) { [ :move ] }

      it 'changes its position' do
        expect(subject.position).to eq(Position.new(x,2, orientation))
      end
    end

    describe 'execute' do
      let(:orientation) { CardinalDirection.west }
      let(:movements) { [:spin_left, :spin_left, :spin_left, :move, :move, :move] }

      before { subject.execute }

      context 'authorized movements' do
        it_behaves_like 'to be located at', 1, 4, :north

        it 'does not have a status' do
          expect(subject.status).to be_nil
        end

        it 'has no remaining movements' do
          expect(subject.movements).to be_empty
        end
      end

      context 'denied movements' do
        let(:grid) { stub :grid, authorize_movement?: RoverControl::Authorization.denied('reason') }

        before { subject.execute }

        it_behaves_like 'to be located at', 1, 1, :north

        it 'has a status' do
          expect(subject.status).to eq('reason')
        end

        it 'has no remaining movements' do
          expect(subject.movements).to be_empty
        end
      end
    end
  end
end