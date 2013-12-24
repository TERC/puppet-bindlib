require 'spec_helper'

describe Puppet::Type.type(:resource_record) do
  let(:testobject) {  Puppet::Type.type(:resource_record) }
  
  describe :name do
    it "should be automatically generated"
  end
    
  describe :origin do
    it "should not be required"
    it "should autocalculate from specified name if not specified"
  end
  
  describe :views do
    it "should not be required"
  end
  
  describe :ttl do
    
  end
 
  [ :a, :ns, :aaaa, :mx ].each do |rr|
    describe rr do
      it "should not be required"
    end
  end
  
  it "should allow setting of parameters in multiple places"
end