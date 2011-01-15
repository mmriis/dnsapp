require 'dnsapp/credentials'
require 'dnsapp/auth_check_parser'

module DNSApp
  class Object #:nodoc: all
    
    @@parent_id = nil
    def parent_id
      @@parent_id
    end
    
    def parent_id=(id)
      @@parent_id = id
    end
    
    include HTTParty
    format :xml
    headers 'Accept' => 'application/xml', 'Content-Type' => 'application/xml'
    base_uri "https://dnsapp.net"
    parser DNSApp::AuthCheckParser

    class << self
      def get(*args)
        basic_auth DNSApp::Credentials.username, DNSApp::Credentials.password
        super
      end
      
      def post(*args)
        basic_auth DNSApp::Credentials.username, DNSApp::Credentials.password
        super
      end
      
      def delete(*args)
        basic_auth DNSApp::Credentials.username, DNSApp::Credentials.password
        super
      end
      
      def put(*args)
        basic_auth DNSApp::Credentials.username, DNSApp::Credentials.password
        super
      end
      
    end
    
    def initialize(attributes=nil)
      attributes and attributes.each do |key, value|
        setter_method = "#{key}=".to_sym
        if self.respond_to?(setter_method)
          self.send(setter_method, value)
        end
      end
    end
    
    def self.check_required_keys(hash, *keys)
      hash.is_a? Hash or raise "Options must be given as a Hash"
      keys.each { |key| raise "Missing required option #{key}" if hash[key].nil? }
    end        
  end
end