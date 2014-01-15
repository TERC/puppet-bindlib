# IP Address validations
shared_examples_for "ipv4 validations" do
  it "should be invalid if value includes an out of range component" do
     params[testparam] = "256.0.0.1"
     expect {
       testobject.new(params)
     }.to raise_error(Puppet::Error, /is not a valid/)
   end
   
   it "should be invalid if value is truncated" do
     params[testparam] = "192.168.0"
     expect {
       testobject.new(params)
     }.to raise_error(Puppet::Error, /is not a valid/)
   end
   
   it "should be invalid if a non-numeric character is included" do
     params[testparam] = "a.168.0.1"
     expect {
       testobject.new(params)
     }.to raise_error(Puppet::Error, /is not a valid/)
   end
   
   it "should be invalid if set to an ipv6 addresses, even if that address is valid" 
end
