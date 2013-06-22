require 'spec_helper'
require 'rover-control/models/grid'

describe Point do
  let(:x) { 4 }
  let(:y) { 3 }
  subject { described_class.new(x,y) }

  describe '#initialize' do
    its(:x) { should == x }
    its(:y) { should == y }

    context 'no parameters' do
      subject { described_class.new }

      its(:x) { should == 0 }
      its(:y) { should == 0 }
    end
  end

  describe '==' do

    specify '2 points are equal if the x and y are the same' do
      other = Point.new(x,y)

      expect(subject).to eq(other)
    end

    specify '2 points are not equal if the x & y are different' do
      other = Point.new(0,0)

      expect(subject).to_not eq(other)
    end

    specify '2 points are not equal if the y is different' do
      other = Point.new(x,0)

      expect(subject).to_not eq(other)
    end

    specify '2 points are not equal if the x is different' do
      other = Point.new(0,y)

      expect(subject).to_not eq(other)
    end
  end
end