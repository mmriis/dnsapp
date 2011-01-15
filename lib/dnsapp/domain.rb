require 'dnsapp/object'

module DNSApp
    
  class Domain < DNSApp::Object
    
    # id for the domain
    attr_accessor :id
    # The domain name
    attr_accessor :name
    # When the domain was created
    attr_accessor :created_at
    # The domain handle
    attr_accessor :handle
    # When the domain was updated
    attr_accessor :updated_at
    # Whether DNSApp.net is authoritative for the domain
    # If +false+ the domain doesn't point to the DNSApp.net nameservers
    attr_accessor :authoritative
    # The user_id for the domain
    attr_accessor :user_id
    # The AUTHID for the domain. Used for transfers.
    attr_accessor :auth_id
    # The status of the domain
    attr_accessor :status
    # Whether the domain is locked. Must be false if you wish to transfer.
    attr_accessor :locked
        
    class << self
      # Retrives all domains
      def all        
        response = get("/domains")["domains"]        
        response.collect { |attributes| Domain.new attributes }
      end
      
      # Find domain by +id+ or +name+
      # == Example
      #  DNSApp::Domain.find(10)
      #  DNSApp::Domain.find("example.org")
      def find(id_or_name)
        if id_or_name.is_a?(Integer)
          find_by_id(id_or_name)
        else
          find_by_name(id_or_name)
        end
      end
      
      # Find domain by +id+
      def find_by_id(id)
        response = get("/domains/#{id}")["domain"]
        response or return nil
        Domain.new response
      end
      
      # Find domain by +name+
      def find_by_name(name)
        domain = self.all.select { |d| d.name == name }
        return domain.blank? ? nil : domain.first
      end
      
      # Creates a new domain
      # +name+ must be without www or similar.
      # == Example
      #  DNSApp::Domain.create("example.org")
      def create(name)
        name.is_a? String or raise TypeError, "name must be string"
        r = post("/domains", :query => {"domain[name]" => name})
        r["errors"] and raise StandardError, r["errors"]["error"].to_a.join(", ")
        if r.code == 201
          Domain.new r["domain"]
        else
          raise StandardError, 'Could not create the domain'
        end        
      end
      
    end
    
    # Deletes the domain. This cannot be undone.
    # Returns the deleted domain object.
    # == Example
    #   DNSApp::Domain.find(10).destroy
    def destroy
      r = self.class.delete("/domains/#{self.id}")
      if r.code == 200
        self
      else
        raise StandardError, 'Could not delete the domain'
      end      
    end
    
    # Get records on the domain.
    # == Example
    #  DNSApp::Domain.find(10).records.all
    #  DNSApp::Domain.find(10).records.create(:name => '%d', :content => '1.2.3.4', :type => 'A', :ttl => 3600)
    def records
      @@parent_id = self.id
      DNSApp::Record
    end
        
  end
  
end