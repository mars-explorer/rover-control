require 'spec_helper'
require 'rover-control/models/grid'

describe Position do
  let(:x)           { 5 }
  let(:y)           { 7 }
  let(:orientation) { :south }
  subject { described_class.new(x, y, orientation) }

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
      other = Position.new(x,y, orientation)

      expect(subject).to eq(other)
    end

    specify '2 positions are not equal if orientation is different' do
      other = Position.new(x,y, :north)

      expect(subject).to_not eq(other)
    end

    specify '2 points are not equal if point is different' do
      other = Position.new(0,0, orientation)

      expect(subject).to_not eq(other)
    end
  end

  describe 'directions' do
    specify 'north' do
      expect(subject.north).to eq(Position.new(x, y+1, orientation))
    end

    specify 'south' do
      expect(subject.south).to eq(Position.new(x, y-1, orientation))
    end

    specify 'east' do
      expect(subject.east).to eq(Position.new(x+1, y, orientation))
    end

    specify 'west' do
      expect(subject.west).to eq(Position.new(x-1, y, orientation))
    end
  end

  describe 'to_point' do
    specify { expect(subject.to_point).to eq(Point.new(5,7)) }
  end
end