require_relative '../string_compression'

RSpec.describe StringCompression do
  describe '::compress' do
    it 'compresses a string' do
      expect(described_class.new.call('aabcccccaaa')).to eq 'a2b1c5a3'
    end

    it 'returns the original string if the compression would make it bigger' do
      expect(described_class.new.call('abcdefgh')).to eq 'abcdefgh'
    end
  end
end
