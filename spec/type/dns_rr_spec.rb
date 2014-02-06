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
      
      # Test exclusions
      ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:exclusions].each do |exclude|
        include_examples "#{exclude} mutually exclusive"
      end
      
      ( ::Puppet_X::Bindlib::Constants::RECORD_TYPES -
        ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:exclusions] ).each do |include|
        include_examples "#{include} not mutually exclusive"
      end

      # Now we load validation and resource specific tests - if present.
      # It's kind of kludgy but the result should be a bit clearer to those less familiar with ruby
      # this way - it just won't test missing shared examples rather than bombing out
      # from the argument error to include_examples.  Instead it will throw up a pending task
      
      # Test validations
      begin
        include_examples "#{::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:validation]} validations"
      rescue ArgumentError => e
        raise e unless !!(e.to_s =~ /Could not find shared examples/)
        it "should test validations via a shared_example named \"#{::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:validation]} validations\""
      end
      
      # Resource specific tests(parameters/etc.)
      begin
        include_examples "#{type} record"
      rescue ArgumentError => e
        raise e unless !!(e.to_s =~ /Could not find shared examples/)
        it "should have resource specific tests via a shared_example named \"#{type} record\""
      end
    end
  end
end