require 'spec_helper'

describe Puppet::Type.type(:dns_zone) do
  let(:testobject) { Puppet::Type.type(:dns_zone) }
   
  it "should test things" do
    params = { :name => "test" }
    testobject.new(params)
  end
end