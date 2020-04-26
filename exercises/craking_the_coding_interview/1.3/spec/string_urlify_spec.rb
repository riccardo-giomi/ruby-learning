require_relative '../string_urlify'

RSpec.describe String do
  context '#urlify' do
    it 'replaces spaces with `%20`' do
      expect('string with spaces'.urlify).to eq 'string%20with%20spaces'
    end

    it 'removes extra spaces' do
      expect('  bloated string  '.urlify).to eq 'bloated%20string'
    end
  end
end
