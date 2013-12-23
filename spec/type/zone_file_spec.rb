require 'spec_helper'

describe Puppet::Type.type(:zone_file) do
  let(:testobject) { Puppet::Type.type(:zone_file) }

  describe :path do
    it "should be required"
    it "should default to the resource name"
  end
    
  describe :include do
    it "should not be required"
    it "should accept resources"
    it "should accept strings"
    it "should accept arrays of strings"
    it "should accept arrays or resources"
    it "should autorequire resources if set with resources"
    it "should autorequire files if passed strings"
  end  
  
  describe :origins do
    it "should be required"
    it "should accept strings"
    it "should accept arrays"
  end
  
  describe :serial do
    it "should default to auto"
  end
  
  describe :views do
    it "should not be required"
  end
  
  describe :ttl do
    
  end
end