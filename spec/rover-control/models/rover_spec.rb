require 'spec_helper'
require 'rover-control/models/rover'

describe RoverControl::Rover do
  let(:initial_position) { stub(:position) }
  let(:movements)        { stub(:movements)}

  subject { described_class.new initial_position, movements }

  describe '#initialize' do
    its(:position)  { should == initial_position }
    its(:movements) { should == movements }
  end
end