require 'dnsapp/object'

module DNSApp
    
  class Record < DNSApp::Object
    
    # id for the record
    attr_accessor :id
    # name for the record
    attr_accessor :name
    # When the record was created
    attr_accessor :created_at
    # When the record was last updated
    attr_accessor :updated_at
    # time-to-live for the record
    attr_accessor :ttl
    # domain_id for the record
    attr_accessor :domain_id
    # content for the record
    attr_accessor :content
    # priority for the record.
    # Only needed for MX and SRV records.
    attr_accessor :prio
    # type for the record
    # Must be one of the following A AAAA NS SOA CNAME TXT SPF SRV MX PTR
    attr_accessor :type
                
    class << self
      
      # Get all the records
      def all 
        response = get("/domains/#{@@parent_id}/records")["records"]        
        response.collect { |attributes| Record.new attributes }
      end
      
      # Find a specific record by +id+
      # == Example
      #   DNSApp::Domain.all.first.find(243)
      #   => #<DNSApp::Record:0x101ad5e88 @name="%d", @domain_id=131, @ttl=3600, @created_at=Mon Jan 10 15:48:02 UTC 2011, @content="1.2.3.4", @type="A", @id=1821, @prio=nil, @updated_at=Mon Jan 10 15:55:29 UTC 2011> 
      def find(id)
        response = get("/domains/#{@@parent_id}/records/#{id}")["record"]
        response or return nil
        Record.new response
      end
      
      # Creates a new record. +options+ must contain at least the following:
      # :name, :content, :type, :tll
      # For SRV and MX records :prio can also be specified.
      # == Valid types
      #   A AAAA NS SOA CNAME TXT SPF SRV MX PTR
      # == Example
      #   DNSApp::Domain.all.first.records.create :name => '%d', :content => '1.2.3.4', :type => 'A', :ttl => 3600
      def create(options={})
        check_required_keys options, :name, :content, :type, :ttl
        
        r = post("/domains/#{@@parent_id}/records", :query => { "record[name]" => options[:name],
                                                                "record[ttl]" => options[:ttl],
                                                                "record[content]" => options[:content],
                                                                "record[prio]" => options[:prio],
                                                                "record[type]" => options[:type] })
        r["errors"] and raise StandardError, r["errors"]["error"].to_a.join(", ")
        if r.code == 201
          Record.new r["record"]
        else
          raise StandardError, 'Could not create the record'
        end        
      end
      
    end
    
    # Saves the record.
    # == Example
    #   r = DNSApp::Domain.all.first.record.first
    #   => #<DNSApp::Record:0x101ad5e88 @name="%d", @domain_id=131, @ttl=3600, @created_at=Mon Jan 10 15:48:02 UTC 2011, @content="1.2.3.4", @type="A", @id=1821, @prio=nil, @updated_at=Mon Jan 10 15:55:29 UTC 2011> 
    #   r.content = '9.9.9.9'
    #   => #<DNSApp::Record:0x101ad5e88 @name="%d", @domain_id=131, @ttl=3600, @created_at=Mon Jan 10 15:48:02 UTC 2011, @content="9.9.9.9", @type="A", @id=1821, @prio=nil, @updated_at=Mon Jan 10 17:52:09 UTC 2011> 
    def save
      r = self.class.put("/domains/#{@@parent_id}/records/#{self.id}", :query => { "record[name]" => self.name,
                                                                                   "record[ttl]" => self.ttl,
                                                                                   "record[content]" => self.content,
                                                                                   "record[prio]" => self.prio,
                                                                                   "record[type]" => self.type })
      r["errors"] and raise StandardError, r["errors"]["error"].to_a.join(", ")
      if r.code == 200
        self.class.find(self.id)
      else
        raise StandardError, 'Could not update the record'
      end
    end
    
    # Deletes the record.
    # Returns the deleted record.
    # == Example
    #  r = DNSApp::Domain.all.first.record.first.destroy
    #  => #<DNSApp::Record:0x101ad5e88 @name="%d", @domain_id=131, @ttl=3600, @created_at=Mon Jan 10 15:48:02 UTC 2011, @content="1.2.3.4", @type="A", @id=1821, @prio=nil, @updated_at=Mon Jan 10 15:55:29 UTC 2011>
    def destroy
      r = self.class.delete("/domains/#{@@parent_id}/records/#{self.id}")
      if r.code == 200
        self
      else
        raise StandardError, 'Could not delete the record'
      end      
    end    
    alias_method :delete, :destroy      
  end
  
end