module Redtail
  class Payload
    
    METADATA_FIELDS = [ :project_root, :hostname, :url, :component, :action]
    
    # The exception
    attr_accessor :exception
    
    # The Sentry key of the sentry server
    attr_accessor :sentry_key
    
    # The exception backtrace
    attr_accessor :backtrace
    
    # The class name of the error
    attr_accessor :error_class
    
    # The exception message or a description of the error
    attr_accessor :error_message
    
    # A hash of parameters from the query string or post body
    attr_accessor :params

    # The component (if any) which was used in this request (usually the controller)
    attr_accessor :component
    alias_method :controller, :component

    # The action (if any) that was called in this request
    attr_accessor :action

    # A hash of session data from the request
    attr_accessor :session_data

    # The path to the project that caused the error (usually Rails.root)
    attr_accessor :project_root

    # The URL at which the error occurred (if any)
    attr_accessor :url
    
    # The host name where this error occurred (if any)
    attr_accessor :hostname
    
    # The name of the client library sending the payload
    attr_accessor :attributable
    
    # A timestamp of when the error occured
    attr_accessor :timestamp
    
    # A numeric severity level (log levels)
    attr_accessor :severity
    
    
    def initialize(exception, args={})
      @exception    = exception
      @severity     = args[:severity] || 1
      @sentry_key   = args[:sentry_key] || Redtail.config.sentry_key
      @attributable = "Redtail v#{Redtail::VERSION}"
      
      @project_root = args[:project_root]
      @hostname     = args[:hostname]
      @url          = args[:url]
      @component    = args[:component]
      @action       = args[:action]
      @params       = args[:params]
      
      @backtrace     = exception.backtrace.join("\n")
      @error_class   = @exception.class.name
      @error_message = "#{@error_class}: #{@exception.message}"
      
      @timestamp  = Time.now.strftime("%FT%T")
      @message_id = UUID.new.generate
    end
    
    def message
      <<-MESSAGE.split("\n").map { |l| l.strip }.join("\n")
        #{@error_message}
        
        #{@backtrace}
        
        -- PARAMS -----------------------------------------------
        
        #{formatted_params}
        
        -- METADATA   -------------------------------------------
        
        #{formatted_metadata}
        
      MESSAGE
    end
    
    # Return a formatted representation of the get or post params
    #
    # @return [String] the formatted params
    def formatted_params
      format_hash(@params)
    end
    
    # Return a formatted representation of the metadata fields
    #
    # @return [String] the formatted metadata fields
    def formatted_metadata
      metadata = {}
      
      METADATA_FIELDS.each { |f| metadata[f] = send(f) }
      
      format_hash(metadata.reject { |k,v| v.nil? })
    end
    
    # Pretty format a hash. Determine the longest key and use
    #   it to pad the other keys
    #
    # @param [Hash] a hash to format
    #
    # @return [String] the pretty formatted and padding string
    def format_hash(hash)
      return nil if hash.nil? || hash.empty?
      
      str = ''
      base_padding = hash.max_by { |k,v| k.length }.flatten.first.length + 3
      
      hash.each do |key, value|
        padding = Array.new( base_padding - key.length ).join(' ')
        str << " #{key}#{padding}=> #{value}\n"
      end
      
      str
    end
    
    def parse_backtrace()
      
    end
    
    # Convert the payload to a hash that sentry understands
    #
    # @return [Hash] a hash representation of the payload
    def to_hash
      { 
        :message     => message,
        :timestamp   => @timestamp,
        :level       => @severity,
        :message_id  => @message_id,
        :view        => "#{@component}::#{@action}",
        :server_name => @hostname,
        :url         => @url,
        :site        => @site,
        # :data      => {}
      }.reject { |k,v| v.nil? }
    end
    
    # Convert the payload hash to JSON
    #
    # @return [String] the JSON string
    def to_json
      to_hash.to_json
    end
    
    # Base64 encode the JSON representation
    #
    # @return [String] Base64 encoded string
    def encode
      Base64.encode64(to_json)
    end
    
  end
end
