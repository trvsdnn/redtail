require 'net/http'
require 'net/https'
require 'openssl'
require 'rubygems'

require 'redtail/version'
require 'redtail/configuration'
require 'redtail/authentication'
require 'redtail/payload'

module Redtail
  
  class << self
    
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
    end

    # The configuration object
    def config
      @config ||= Configuration.new
    end
    
    def log_to_sentry
      
    end
    
  end
  
end
