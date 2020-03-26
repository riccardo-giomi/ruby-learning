require 'addressable/uri'
require_relative '../../support/uri_parser_shared_examples.rb'

module Addressable
  RSpec.describe URI do
    it_behaves_like 'URI parser', described_class

    it 'does not give a default port' do
      expect(described_class.parse('http://example.com/').port).to be_nil
    end

    it 'can infer the port for an http URI as 80' do
      expect(described_class.parse('http://example.com/').inferred_port).to eq 80
    end

    it 'can infer the port for an https URI as 443' do
      expect(described_class.parse('https://example.com/').inferred_port).to eq 443
    end
  end
end
