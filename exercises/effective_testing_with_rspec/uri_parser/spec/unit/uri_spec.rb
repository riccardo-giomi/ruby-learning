require 'uri'
require_relative '../support/uri_parser_shared_examples.rb'

RSpec.describe URI do
  it_behaves_like 'URI parser', described_class

  it 'defaults the port for an http URI to 80' do
    expect(described_class.parse('http://example.com/').port).to eq 80
  end

  it 'defaults the port for an https URI to 443' do
    expect(described_class.parse('https://example.com/').port).to eq 443
  end
end
