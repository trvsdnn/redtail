module Redtail
  class Authorization
    
    # The message to be sent
    attr_reader :message
    
    # The timestamp for when the message was generated
    attr_reader :timestamp
    
    def initialize(message, timestamp)
      @message   = message
      @timestamp = timestamp.to_f.to_s[0..11]
    end
    
    # Generate HMAC hexdigest signature for sentry
    #
    # @return [String] the signature
    def signature
      OpenSSL::HMAC.hexdigest('sha1', Redtail.config.sentry_key, "#{@timestamp} #{@message}")
    end
    
    # Generate the Authorization header for the HTTP post
    #
    # @return [String] the HTTP Auth header
    def header
      "Sentry sentry_signature=#{signature}, sentry_timestamp=#{@timestamp}, redtail=#{VERSION}"
    end
    
  end
end