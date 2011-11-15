require 'net/http'
require 'net/https'
require 'openssl'
require 'base64'
require 'rubygems'
require 'json'
require 'uuid'

require 'redtail/version'
require 'redtail/configuration'
require 'redtail/forwarder'
require 'redtail/authorization'
require 'redtail/payload'

module Redtail
  
  class << self
    
    attr_accessor :forwarder
    
    attr_writer :config
    
    # Allow configuring options with a block
    #
    # @example
    #   Redtail.configure do |config|
    #     config.sentry_key = 'fedcba0987654321'
    #     config.port  = 8080
    #   end
    def configure(silent = false)
      yield(config)
      self.forwarder = Forwarder.new(config)
    end

    # The configuration object
    def config
      @config ||= Configuration.new
    end
    
    def log_to_sentry(exception, opts={})
      payload = Payload.new(exception, opts)
      forwarder.forward(payload.encode)
    end
    
  end
  
end
