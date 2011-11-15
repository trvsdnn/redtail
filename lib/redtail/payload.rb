module Redtail
  class Payload
    
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
    attr_accessor :parameters
    alias_method :params, :parameters

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
    attr_accessor :severity_level
    
    
    
    
    
  end
end