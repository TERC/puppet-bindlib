# IP Address validations
shared_examples_for "ipv6 validations" do
  it "should be invalid if set to an ipv4 addresses, even if that address is valid" do
    params[testparam] = "192.168.0.1"
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /is not a valid/)
  end
end