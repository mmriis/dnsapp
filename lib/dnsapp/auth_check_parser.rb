require 'httparty'

module DNSApp

  class Unauthorized < Exception #:nodoc:
  end

  class AuthCheckParser < HTTParty::Parser #:nodoc:
    def parse
      raise DNSApp::Unauthorized, "Access Denied. Maybe you supplied wrong credentials?" if body =~ /HTTP Basic: Access denied./i
      super
    end
  end

end