require_relative '../string_press.rb'

RSpec.describe StringPress do
  describe '::compress' do
    it 'compresses a string' do
      expect(described_class.compress('aabcccccaaa')).to eq 'a2b1c5a3'
    end

    it 'returns the original string if the compression would make it bigger' do
      expect(described_class.compress('abcdefgh')).to eq 'abcdefgh'
    end
  end
end
