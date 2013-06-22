require 'spec_helper'
require 'rover-control/models/grid'

describe Grid do
  let(:width)  { 5 }
  let(:height) { 6 }

  subject { described_class.new(width,height) }

  describe '#initialize' do
    its(:width)  { should == width }
    its(:height) { should == height }

    context 'no parameters' do
      subject { described_class.new }

      its(:width)  { should == 0 }
      its(:height) { should == 0 }
    end
  end

  describe '==' do

    specify '2 points are equal if the width and height are the same' do
      other = Grid.new(width,height)

      expect(subject).to eq(other)
    end

    specify '2 points are not equal if the width and height are different' do
      other = Grid.new(0,0)

      expect(subject).to_not eq(other)
    end

    specify '2 points are not equal if the height is different' do
      other = Grid.new(width,0)

      expect(subject).to_not eq(other)
    end

    specify '2 points are not equal if the width is different' do
      other = Grid.new(0,height)

      expect(subject).to_not eq(other)
    end
  end
end