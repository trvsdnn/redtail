require File.expand_path('../helper', __FILE__)

SENTRY_KEY = 'abc123'

describe Redtail::Authorization do
  
  before do
    @timestamp = 1321368902
    @message   = 'blah blah foo bar'
    
    Redtail.configure do |config|
      config.sentry_key = SENTRY_KEY
    end
  end
  
  it 'creates an hmac signature' do
    signature = Redtail::Authorization.new(@message, @timestamp).signature
    
    signature.must_equal "f46a9076677b13b11157406de1df977a18f4c801"
  end
  
  it 'creates an HTTP Authorization header' do
    header = Redtail::Authorization.new(@message, @timestamp).header
    
    header.must_equal "Sentry sentry_signature=f46a9076677b13b11157406de1df977a18f4c801, sentry_timestamp=1321368902, redtail=#{Redtail::VERSION}"
  end
  
end
