module Redtail
  class Authentication
    
    # The message to be sent
    attr_reader :message
    
    # The timestamp for when the message was generated
    attr_reader :timestamp
    
    def initialize(timestamp, message)
      @timestamp = timestamp
      @message   = message
    end
    
    # Generate HMAC hexdigest signature for sentry
    #
    # @return [String] the signature
    def signature
      OpenSSL::HMAC.hexdigest('sha1', Redtail.config.sentry_key, "#{@timestamp} #{@message}")
    end
    
    # A string representing the client version, used in the
    # Authorization headers
    #
    # @return [String] the version
    def version
      "Redtail v#{Redtail::VERSION}"
    end
    
    
  end
end
