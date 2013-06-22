require 'spec_helper'
require 'rover-control/validators/instructions_validator'

shared_examples_for 'invalid instructions' do |message|
  specify { expect(subject).to_not be_valid }
  specify { expect(subject.errors).to include message }
end

describe RoverControl::InstructionsValidator do
  let(:instructions) do
<<-eos
5 5
2 5 S
LLM
eos
  end

  subject { RoverControl::InstructionsValidator.new instructions }

  describe 'valid?' do
    context 'valid instructions' do
      it 'returns true' do
        expect(subject).to be_valid
      end

      it 'has no error' do
        #puts subject.errors.inspect
        expect(subject.errors).to be_empty
      end
    end

    context 'invalid number of line' do
      let(:instructions) { " 5 5\n2 5 S" }

      it_behaves_like 'invalid instructions', 'invalid number of instructions'
    end

    context 'invalid grid size' do
      let(:instructions) { "A 5\n2 5 S\nLLM" }

      it_behaves_like 'invalid instructions', 'invalid grid dimension (A 5)'
    end

    context 'invalid initial position' do
      let(:instructions) { "5 5\nS 2 S\nLLM" }

      it_behaves_like 'invalid instructions', 'invalid rover position (S 2 S)'
    end

    context 'invalid initial orientation' do
      let(:instructions) { "5 5\n2 2 A\nLLM" }

      it_behaves_like 'invalid instructions', 'invalid rover position (2 2 A)'
    end

    context 'invalid initial movement' do
      let(:instructions) { "5 5\n2 2 S\nLLNR" }

      it_behaves_like 'invalid instructions', 'invalid rover movements (LLNR)'
    end
  end
end