module Redtail
  class Configuration
    OPTIONS = [
      :sentry_key, :host, :port, :secure,
      :protocol, :store_uri,
      :http_open_timeout, :http_read_timeout
    ].freeze
    
    # The Sentry key of the server
    attr_accessor :sentry_key
  
    # The host running the Sentry server (defaults to localhost)
    attr_accessor :host
    
    # The store path on the Sentry server (defaults to /store)
    attr_accessor :store_uri

    # The port your Sentry server is running on (defaults to 80)
    attr_accessor :port

    # +true+ for https connections, +false+ for http connections.
    attr_accessor :secure

    # The HTTP open timeout in seconds (defaults to 2).
    attr_accessor :http_open_timeout

    # The HTTP read timeout in seconds (defaults to 5).
    attr_accessor :http_read_timeout
  
    def initialize
      @host              = 'localhost'
      @store_uri         = '/store'
      @secure            = false
      @http_open_timeout = 2
      @http_read_timeout = 5
    end
  
    alias_method :secure?, :secure
  
    # Access the config as a hash
    #
    # @param [Symbol] the attribute to be accessed
    def [](option)
      send(option)
    end
    
    # Returns a hash version of all configured options
    #
    # @return [Hash] the configured options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash.merge(option => send(option))
      end
    end
  
    # Build the sentry store url from the host, port, and url
    #
    # @return [String] the 
    def store_url
      @store_url ||= "#{protocol}://#{@host}:#{@port}#{@store_uri}"
    end
  
    # Return the protocol for the current config
    #
    # @return [String] the http protocol for the config
    def protocol
      secure? ? 'https' : 'http'
    end
  
    # Return the set port or the default port
    #
    # @return [Fixnum] the port
    def port
      @port ||= default_port
    end
  
    # Return the default port based on the protocol
    #
    # @return [Fixnum] the http port
    def default_port
      secure? ? 443 : 80
    end
  end
end
