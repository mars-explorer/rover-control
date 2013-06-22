require 'spec_helper'
require 'rover-control/models/grid'

describe Position do
  subject { described_class.new(5,6, :south) }

  describe '#initialize' do
    specify { expect(Position.ancestors).to include(Point) }
    its(:x) { should == 5 }
    its(:y) { should == 6 }

    context 'no parameters' do
      subject { described_class.new }

      its(:x) { should == 0 }
      its(:y) { should == 0 }
    end
  end
end