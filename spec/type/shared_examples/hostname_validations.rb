
shared_examples_for "hostname validations" do
  it "should be invalid if any component is over 63 characters" do
    params[testparam] = "01234567890123456789012345678901234567890123456789012345678901234567891234.example.com"
      expect {
        testobject.new(params)
    }.to raise_error(Puppet::Error, /is not a valid/)
  end
  it "should be invalid if any component is less than 1 character" do
    params[testparam] = "test..example.com"
      expect {
        testobject.new(params)
    }.to raise_error(Puppet::Error, /is not a valid/)
  end
  #it "should be invalid if "
end