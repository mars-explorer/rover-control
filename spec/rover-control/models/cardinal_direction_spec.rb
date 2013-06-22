require 'spec_helper'
require 'rover-control/models/cardinal_direction'

describe CardinalDirection do
  describe 'north' do
    subject { CardinalDirection.north }

    its(:name)  { should == :north }
    its(:left)  { should == CardinalDirection.west }
    its(:right) { should == CardinalDirection.east }
  end

  describe 'south' do
    subject { CardinalDirection.south }

    its(:name)  { should == :south }

    its(:left)  { should == CardinalDirection.east }
    its(:right) { should == CardinalDirection.west }
  end

  describe 'east' do
    subject { CardinalDirection.east }

    its(:name)  { should == :east }
    its(:left)  { should == CardinalDirection.north }
    its(:right) { should == CardinalDirection.south }
  end

  describe 'west' do
    subject { CardinalDirection.west }

    its(:name)  { should == :west }
    its(:left)  { should == CardinalDirection.south }
    its(:right) { should == CardinalDirection.north }
  end
end