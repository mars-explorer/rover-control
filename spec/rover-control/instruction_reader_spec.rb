require 'spec_helper'
require "rover-control/instruction_reader"

describe RoverControl::InstructionReader do
  class ToTestReader
    include RoverControl::InstructionReader
    attr_accessor :instructions
  end

  subject { ToTestReader.new }

  before do
    subject.instructions = "5 5\n2 2 S\nLLL\n3 3 N\nMMM".split("\n")
  end

  its(:grid_definition) { should == '5 5' }
  specify { expect(subject.executions.to_a).to match_array [['2 2 S', 'LLL'], ['3 3 N', 'MMM']] }
end