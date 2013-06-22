require 'spec_helper'
require 'rover-control/output/rover_output_builder'

describe RoverControl::RoverOutputBuilder do
  let(:rover) { stub(:rover, x: 1, y: 2, orientation: orientation, status: nil) }
  subject { described_class.new rover }

  describe 'build' do
    context 'north' do
      let(:orientation) { CardinalDirection.north }

      its(:build) { should == '1 2 N' }
    end

    context 'south' do
      let(:orientation) { CardinalDirection.south }

      its(:build) { should == '1 2 S' }
    end

    context 'east' do
      let(:orientation) { CardinalDirection.east }

      its(:build) { should == '1 2 E' }
    end

    context 'west' do
      let(:orientation) { CardinalDirection.west }

      its(:build) { should == '1 2 W' }
    end
  end

  describe 'with a status' do
    let(:rover) { stub(:rover, x: 1, y: 2, orientation: CardinalDirection.south, status: 'stopped for a reason') }

    its(:build) { should == '1 2 S (stopped for a reason)' }
  end
end