module Redtail
  class Forwarder
    
    attr_reader :protocol, :host, :port, :secure, :store_uri,
                :http_open_timeout, :http_read_timeout
    
    def initialize(options)
      [ :protocol, :host, :port, :secure, :store_uri,
        :http_open_timeout, :http_read_timeout ].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end
    
    # Send the request to the Sentry server
    #
    # @param [Hash] the hash of data to send
    def forward(data)
      timestamp = Time.now
      http      = Net::HTTP.new(url.host, url.port)
      
      http.read_timeout = http_read_timeout
      http.open_timeout = http_open_timeout
      
      
      request = Net::HTTP::Post.new(url.request_uri)
      request['Authorization'] = Authorization.new(data, timestamp).header
      request['Content-Type']  = 'application/octet-stream'
      request.body = data
      
      if secure
        http.use_ssl     = true
        http.ca_file     = OpenSSL::X509::DEFAULT_CERT_FILE if File.exist?(OpenSSL::X509::DEFAULT_CERT_FILE)
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      else
        http.use_ssl = false
      end
      
      response = nil
      
      begin
        response = http.request(request)
      rescue Exception => e
        puts "Timeout while connecting to the Sentry server"
      end
    end
    
    # Build up a url string and parse it
    #
    # @return [URI] the URI object
    def url
      URI.parse("#{protocol}://#{host}:#{port}#{store_uri}")
    end
    
  end
end
