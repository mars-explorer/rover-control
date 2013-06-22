require 'spec_helper'
require 'rover-control/models/grid'

shared_examples_for 'stop to not exit the grid' do

  it 'is denied' do
    authorization = subject.authorize_movement? position

    expect(authorization).to_not be_granted
  end

  it 'has a reason' do
    authorization = subject.authorize_movement? position

    expect(authorization.reason).to eq('stopped to not exist the grid')
  end

end

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

  describe 'authorize_movement?' do
    context 'inside the grid' do
      let(:position) { Position.new(2, 2, :north) }

      it 'is granted' do
        authorization = subject.authorize_movement? position

        expect(authorization).to be_granted
      end
    end

    context 'too low' do
      let(:position) { Position.new(2, -2, :north) }

      it_behaves_like 'stop to not exit the grid'
    end

    context 'too high' do
      let(:position) { Position.new(2, 7, :north) }

      it_behaves_like 'stop to not exit the grid'
    end

    context 'too much on the left' do
      let(:position) { Position.new(-2, 2, :north) }

      it_behaves_like 'stop to not exit the grid'
    end

    context 'too much on the right' do
      let(:position) { Position.new(6, 2, :north) }

      it_behaves_like 'stop to not exit the grid'
    end
  end
end