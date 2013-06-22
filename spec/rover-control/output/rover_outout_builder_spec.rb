require 'spec_helper'
require 'rover-control/output/rover_output_builder'

describe RoverControl::RoverOutputBuilder do
  let(:rover) { stub(:rover, x: 1, y: 2, orientation: orientation) }
  subject { described_class.new rover }

  describe 'build' do

    context 'north' do
      let(:orientation) { :north }

      its(:build) { should == '1 2 N' }
    end

    context 'south' do
      let(:orientation) { :south }

      its(:build) { should == '1 2 S' }
    end

    context 'east' do
      let(:orientation) { :east }

      its(:build) { should == '1 2 E' }
    end

    context 'west' do
      let(:orientation) { :west }

      its(:build) { should == '1 2 W' }
    end
  end
end