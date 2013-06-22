require 'spec_helper'
require 'rover-control/models/grid'

describe Grid do
  subject { described_class.new(5,6) }

  describe '#initialize' do
    its(:width)  { should == 5 }
    its(:height) { should == 6 }

    context 'no parameters' do
      subject { described_class.new }

      its(:width)  { should == 0 }
      its(:height) { should == 0 }
    end
  end
end