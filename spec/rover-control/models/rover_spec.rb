require 'spec_helper'
require 'rover-control/models/rover'

shared_examples_for 'to be located at' do |expected_x, expected_y, expected_orientation|
  specify { expect(subject.position.x).to eq(expected_x) }
  specify { expect(subject.position.y).to eq(expected_y) }
  specify { expect(subject.position.orientation).to eq(expected_orientation) }
end

describe RoverControl::Rover do
  let(:x) { 1 }
  let(:y) { 1 }
  let(:orientation) { :north}
  let(:initial_position) { Position.new(x,y,orientation) }
  let(:movements)        { [:spin_right] }

  subject { described_class.new initial_position, movements }

  describe '#initialize' do
    its(:position)  { should == initial_position }
    its(:movements) { should == movements }
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

      describe 'from the south' do
        let(:orientation) { :south }

        it_behaves_like 'to be located at', 1, 1, :east
      end

      describe 'from the north' do
        let(:orientation) { :north }

        it_behaves_like 'to be located at', 1, 1, :west
      end

      describe 'from the west' do
        let(:orientation) { :west }

        it_behaves_like 'to be located at', 1, 1, :south
      end

      describe 'from the east' do
        let(:orientation) { :east }

        it_behaves_like 'to be located at', 1, 1, :north
      end
    end

    describe 'spin_right' do
      let(:movements) { [ :spin_right ] }

      describe 'from the south' do
        let(:orientation) { :south }

        it_behaves_like 'to be located at', 1, 1, :west
      end

      describe 'from the north' do
        let(:orientation) { :north }

        it_behaves_like 'to be located at', 1, 1, :east
      end

      describe 'from the west' do
        let(:orientation) { :west }

        it_behaves_like 'to be located at', 1, 1, :north
      end

      describe 'from the east' do
        let(:orientation) { :east }

        it_behaves_like 'to be located at', 1, 1, :south
      end
    end

    describe 'move' do
      let(:movements) { [ :move ] }

      describe 'from the south' do
        let(:orientation) { :south }

        it_behaves_like 'to be located at', 1, 0, :south
      end

      describe 'from the north' do
        let(:orientation) { :north }

        it_behaves_like 'to be located at', 1, 2, :north
      end

      describe 'from the west' do
        let(:orientation) { :west }

        it_behaves_like 'to be located at', 0, 1, :west
      end

      describe 'from the east' do
        let(:orientation) { :east }

        it_behaves_like 'to be located at', 2, 1, :east
      end
    end

    describe 'execute' do
      let(:orientation) { :west }
      let(:movements) { [:spin_left, :spin_left] }

      before { subject.execute }

      it_behaves_like 'to be located at', 1, 1, :east

      it 'has no remaining movements' do
        expect(subject.movements).to be_empty
      end
    end
  end
end