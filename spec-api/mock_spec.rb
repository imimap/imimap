# frozen_string_literal: true

# litte example class
class Die
  attr_accessor :default
  def roll
    default || 6
  end
end

describe 'die' do
  let(:die) { Die.new }
  context 'real die' do
    it 'rolls a 6' do
      expect(die.roll).to eq 6
    end
  end

  context 'test double for instance' do
    let(:die_mock) { double('die') }
    it 'rolls a 4' do
      allow(die_mock).to receive(:roll).and_return(4)
      expect(die_mock.roll).to eq 4
    end
    it 'call without expect' do
      expect { die_mock.roll }.to raise_error
    end
  end
  context 'mock for class' do
    let(:die_mock) { instance_double('Die') }
    it 'rolls a 6' do
      allow(die_mock).to receive(:roll).and_return(3)
      expect(die_mock.roll).to eq 3
    end
    it 'call without expect' do
      expect { die_mock.roll }.to raise_error
    end
  end
end
