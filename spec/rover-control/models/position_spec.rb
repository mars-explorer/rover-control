require 'spec_helper'
require 'rover-control/models/grid'

describe Position do
  let(:x) { 5 }
  let(:y) { 7 }
  subject { described_class.new(x, y, :south) }

  describe '#initialize' do
    specify { expect(Position.ancestors).to include(Point) }

    its(:x) { should == x }
    its(:y) { should == y }

    context 'no parameters' do
      subject { described_class.new }

      its(:x) { should == 0 }
      its(:y) { should == 0 }
    end
  end

  describe '==' do

    specify '2 positions are equal if point and the orientation are the same' do
      other = Position.new(x,y, :south)

      expect(subject).to eq(other)
    end

    specify '2 positions are not equal if orientation is different' do
      other = Position.new(x,y, :north)

      expect(subject).to_not eq(other)
    end

    specify '2 points are not equal if point is different' do
      other = Position.new(0,0, :south)

      expect(subject).to_not eq(other)
    end
  end
end