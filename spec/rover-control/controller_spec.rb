require 'spec_helper'
require 'stringio'

describe RoverControl::Controller do
  let(:output)    { '' }
  let(:mock_io)   { StringIO.new(output) }

  let(:instruction_parser_class) { stub(:parser, new: instruction_parser) }
  let(:instruction_parser)       { mock(:parser) }
  let(:environment_builder)      { mock(:env_builder) }

  let(:rover)           { stub(:rover, execute: 'should execute') }
  let(:environment)     { stub(:env, rovers: [rover])}

  let(:output_builder_class) { stub(:output_builder, new: output_builder) }
  let(:output_builder)       { mock(:output_builder) }

  subject do
    described_class.new mock_io,
                        instruction_parser_class,
                        environment_builder,
                        output_builder_class
  end

  describe '#execute' do
    let(:instructions)        { stub(:instructions) }
    let(:parsed_instructions) { stub(:parsed_instructions)}

    before do
      instruction_parser.should_receive(:parse).and_return(parsed_instructions)
      environment_builder.should_receive(:build).with(parsed_instructions).and_return(environment)
      output_builder.should_receive(:build).and_return('expected output')
    end

    it 'outputs the instructions result into the io' do
      subject.execute(instructions)

      expect(output).to eq("expected output\n")
    end
  end
end