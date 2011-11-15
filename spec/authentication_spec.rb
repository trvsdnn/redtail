require File.expand_path('../helper', __FILE__)

SENTRY_KEY = 'abc123'

describe Redtail::Authentication do
  
  before do
    Redtail.configure do |config|
      config.sentry_key = SENTRY_KEY
    end
  end
  
  it 'creates an hmac signature' do
    timestamp = Time.now.to_i
    message   = 'blah blah foo bar'
    signature = Redtail::Authentication.new(timestamp, message).signature
    
    signature.must_equal OpenSSL::HMAC.hexdigest('sha1', SENTRY_KEY, "#{timestamp} #{message}")
    
  end
  
end
