require 'spec_helper'
require 'rover-control/models/authorization'

describe RoverControl::Authorization do

  describe '.granted' do
    subject { RoverControl::Authorization.granted }

    it 'is authorized' do
      expect(subject).to be_granted
    end

    it 'does not have any reason' do
      expect(subject.reason).to be_nil
    end
  end

  describe '.denied' do
    subject { RoverControl::Authorization.denied('reason') }

    it 'is authorized' do
      expect(subject).to_not be_granted
    end

    it 'does not have any reason' do
      expect(subject.reason).to eq('reason')
    end
  end
end