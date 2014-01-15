require 'spec_helper'

describe Puppet::Type.type(:dns_rr) do
  let(:testobject) {  Puppet::Type.type(:dns_rr) }

  # Thought better of this behavior
  #it "should raise an exception if no resource record is set" do
  #  expect {
  #    testobject.new({:name => "test.example.com"})
  #  }.to raise_error(Puppet::Error, /set at least one resource record type/)
  #end
  
  # TYPE PARAMETER TESTS
  # Define types in the following happy funtime constant
  TYPES = [ :a, :aaaa, :cname, :mx, :ns, :ptr ]
  # each type should have a corresponding shared example file in 
  # spec/type/shared_examples/resource_records and shared_examples_for
  # "#{type} record" "#{type} not mutually exclusive" and "#{type} mutually exclusive"
    
  # And then we actaully iterate through them.
  TYPES.each do |type|
    describe "#{type}" do
      let(:testparam) { type }
      # Kinda kludgy but it should be a bit clearer to those less familiar with ruby
      # this way
      begin
        include_examples "#{type} record"
      rescue ArgumentError => e
        raise e unless !!(e.to_s =~ /Could not find shared examples/)
        it "a shared_example named \"#{type} record\" should be present"
      end
    end
  end
end