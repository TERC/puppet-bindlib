require 'spec_helper'

describe Puppet::Type.type(:dns_rr) do
  let(:testobject) {  Puppet::Type.type(:dns_rr) }

  # Thought better of this behavior
  #it "should raise an exception if no resource record is set" do
  #  expect {
  #    testobject.new({:name => "test.example.com"})
  #  }.to raise_error(Puppet::Error, /set at least one resource record type/)
  #end
  
  describe :owner do
    it "should default to resource name" do
      params = { :name => "test.example.com" }
      puts testobject.new(params).parameters[:owner].value
    end
  end
  
  describe :origin do
    it "should default to a best guess based on name" do
      params = { :name => "test.example.com" }
      puts testobject.new(params).parameters[:origin].value
    end
  end
  
  # Same constants as the actual code
  ::Puppet_X::Bindlib::Constants::RECORD_TYPES.each do |type|
    describe "#{type}" do
      let(:testparam) { type }
      # Universal test  
      it "should exist as a parameter" do
        testobject.parameters.include?(testparam).should be_true
      end
      
      # Resource specific tests(parameters/etc.)
      begin
        include_examples "#{type} record"
      rescue ArgumentError => e
        raise e unless !!(e.to_s =~ /Could not find shared examples/)
        
        # Note that a ton of things are going to fail
        it "should have resource specific tests via a shared_example named \"#{type} record\""
      end 
      
      # Include the resource record
      include_examples "resource record"
         
      # Test validations
      begin
        include_examples "#{::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:validation]} validations"
      rescue ArgumentError => e
        raise e unless !!(e.to_s =~ /Could not find shared examples/)
        it "should test validations via a shared_example named \"#{::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:validation]} validations\""
      end
      
      # Test exclusions
      ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:exclusions].each do |exclude|
        it "should be mutually exclusive with #{exclude}" do
          validation = ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[exclude][:validation]
          expect {
            params[exclude] = ::Puppet_X::Bindlib::Constants::VALID_RECORD_LOOKUP[validation.to_sym]
            testobject.new(params) 
          }.to raise_error
        end
      end
      
      ( ::Puppet_X::Bindlib::Constants::RECORD_TYPES -
        ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:exclusions] ).each do |include|
        it "should not be mutually exclusive with #{include}" do
          validation = ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[include][:validation]
          expect {
            params[include] = ::Puppet_X::Bindlib::Constants::VALID_RECORD_LOOKUP[validation.to_sym]
            testobject.new(params) 
          }.not_to raise_error
        end
      end
    end
  end
end