module DNSApp

  class Credentials
    class << self
  
      # Set DNSApp username.
      # This must be done before connecting.
      # == Example
      #    DNSApp::Credentials.username = 'mmr@dnsapp.net'
      #    DNSApp::Credentials.password = 'p@ssw0rd'
      #    DNSApp::Domain.all
      def username=(username)
        @username = username
      end
    
      def username #:nodoc:
        @username
      end
      
      # Set DNSApp password.
      # This must be done before connecting.
      # == Example
      #    DNSApp::Credentials.username = 'mmr@dnsapp.net'
      #    DNSApp::Credentials.password = 'p@ssw0rd'
      #    DNSApp::Domain.all
      def password=(password)
        @password = password
      end
      
      def password #:nodoc:
        @password
      end
    end
  end

end