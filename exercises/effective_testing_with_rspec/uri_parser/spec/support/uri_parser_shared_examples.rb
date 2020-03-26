RSpec.shared_examples 'URI parser' do |uri_class|
  it 'parses the scheme' do
    expect(uri_class.parse('https://a.com').scheme).to eq 'https'
  end

  it 'parses the host' do
    expect(uri_class.parse('http://foo.com/').host).to eq 'foo.com'
  end

  it 'parses the port' do
    expect(uri_class.parse('http://example.com:9876').port).to eq 9876
  end

  it 'parses the path' do
    expect(uri_class.parse('http://a.com/foo').path).to eq '/foo'
  end
end
