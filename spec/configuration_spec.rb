require File.expand_path('../helper', __FILE__)

describe Redtail::Configuration do
  
  it 'provides default values' do
    config = Redtail::Configuration.new
    
    config.host.must_equal 'localhost'
    config.store_uri.must_equal '/store'
    config.secure.must_equal false
    config.http_open_timeout.must_equal 2
    config.http_read_timeout.must_equal 5
    config.port.must_equal 80
    config.protocol.must_equal 'http'
    config.store_url.must_equal 'http://localhost:80/store'
  end
  
  it 'has default values for secure connections' do
    config = Redtail::Configuration.new
    config.secure = true
    
    config.port.must_equal 443
    config.protocol.must_equal 'https'
  end

  it 'has default values for insecure connections' do
    config = Redtail::Configuration.new
    config.secure = false
    
    config.port.must_equal 80
    config.protocol.must_equal 'http'
  end
  
  it 'acts like a hash' do
    config = Redtail::Configuration.new
    hash = config.to_hash
    
    Redtail::Configuration::OPTIONS.each do |option|
      config[option].must_equal hash[option]
    end
  end
  
end