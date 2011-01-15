require 'lib/dnsapp'
require 'yaml'
require 'rspec'

describe DNSApp::Record do
  
  before(:all) do
    yml = YAML::load(File.open("spec/credentials.yml"))
    DNSApp::Credentials.username = yml["username"]
    DNSApp::Credentials.password = yml["password"]

    @domain = DNSApp::Domain.create("test-example-1.com")
  end
  
  after(:all) do
    DNSApp::Domain.find("test-example-1.com").destroy
  end
  
  describe '#all' do
    it 'should return a list of records' do
      records = @domain.records.all.collect(&:type)
      records.should =~ %w(SOA NS NS NS NS NS)
    end
  end
  
  describe '#find' do
    it 'should return the record with id' do
      record = @domain.records.find(@domain.records.all.first.id)
      record.should_not be_nil
      record.id.should == @domain.records.all.first.id
    end
  end
  
  describe '#create' do
    it 'should create a record with the specified attributes' do
      @domain.records.create :name => '%d', :content => '1.2.3.4', :type => 'A', :ttl => 300
      record = @domain.records.all.last
      record.name.should == '%d'
      record.content.should == '1.2.3.4'
      record.type.should == 'A'
      record.ttl.should == 300
      record.prio.should be_nil
    end
  end
  
  describe '#save' do
    it 'should update a record with the new attributes' do
      record = @domain.records.all.first
      record.name = 'test1.%d'
      record.content = 'test2'
      record.type = 'CNAME'
      record.ttl = 5000
      record.prio = 10
      record.save
      
      record = @domain.records.find(record.id) # reload the record
      record.name.should == 'test1.%d'
      record.content.should == 'test2'
      record.type.should == 'CNAME'
      record.ttl.should == 5000
      record.prio.should == 10
    end
  end
  
  describe '#destroy' do
    it 'should destroy the record' do
      number_of_records = @domain.records.all.length
      @domain.records.all.last.destroy
      @domain.records.all.length.should == number_of_records - 1
    end
  end
  
end