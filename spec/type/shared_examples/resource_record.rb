# General resource record tests.  Should be included in every more specific resource record test.
shared_examples "resource record" do
  it "should exist as a parameter" do
    testobject.parameters.include?(testparam).should be_true
  end
  
  it "should be valid given a valid value" do
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end