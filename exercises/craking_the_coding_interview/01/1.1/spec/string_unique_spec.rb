require_relative '../string_unique.rb'

RSpec.describe String do
  context '#unique?' do
    it 'returns true for an empty string' do
      expect(''.unique?).to be true
    end

    it 'returns true if the string contains only unique characters' do
      expect('abc'.unique?).to be true
    end

    it 'returns false if the string contains repeating characters' do
      expect('aaa'.unique?).to be false
    end
  end
end
