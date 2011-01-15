require 'lib/dnsapp'
require 'yaml'
require 'rspec'

describe DNSApp::Domain do
  
  before(:all) do
    yml = YAML::load(File.open("spec/credentials.yml"))
    DNSApp::Credentials.username = yml["username"]
    DNSApp::Credentials.password = yml["password"]

    @domain1 = DNSApp::Domain.create("test-example-1.com")
    @domain2 = DNSApp::Domain.create("test-example-2.com")
  end
  
  after(:all) do
    DNSApp::Domain.find("test-example-1.com").destroy
    DNSApp::Domain.find("test-example-2.com").destroy
  end
  
  describe '#all' do
    it 'should return a list of domains' do
      domains = DNSApp::Domain.all.collect(&:name)
      domains.should include("test-example-1.com")
      domains.should include("test-example-2.com")
    end
  end
  
  describe '#find' do
    it 'should return the domain with id' do
      DNSApp::Domain.find(@domain1.id).name.should == "test-example-1.com"
    end
    
    it 'should return the domain with name' do
      DNSApp::Domain.find(@domain2.name).name.should == "test-example-2.com"
    end
  end
  
  describe '#create' do
    before(:all) do
      @example_domain = DNSApp::Domain.create('some-example-domain.com')
    end
    
    after(:all) do
      @example_domain.destroy
    end
    
    it 'should create a domain with the specified name' do
      DNSApp::Domain.find(@example_domain.name).name.should == @example_domain.name
    end
    
    it 'should not be possible to create duplicate domains' do
      lambda { DNSApp::Domain.create(@example_domain.name) }.should raise_error
    end
  end
  
  describe '#destroy' do
    it 'should destroy the domain' do
      domain = DNSApp::Domain.create('some-example-domain-to-be-destroyed.com')
      domain.destroy
      DNSApp::Domain.find('some-example-domain-to-be-destroyed.com').should be_nil
    end
  end
  
  describe '#records' do
    it 'should return the record object' do
      @domain1.records.should == DNSApp::Record
    end
  end
  
end