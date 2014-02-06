shared_examples_for "ptr not mutually exclusive" do
  it "should not be mutually exclusive with PTR records" do
    params[:ptr] =  "test.example.com."
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end

shared_examples_for "ptr mutually exclusive" do
  it "should be mutually exclusive with PTR records" do
    params[:ptr] =  "test.example.com."
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /mutual/)
  end
end

shared_examples "ptr record" do
  let(:params) {{ :name => "192.168.0.1", :ptr => "test.example.com." }}
  
  include_examples "resource record"
end