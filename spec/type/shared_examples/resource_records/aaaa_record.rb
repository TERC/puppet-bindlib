shared_examples_for "aaaa not mutually exclusive" do
  it "should not be mutually exclusive with AAAA records" do
    params[:aaaa] =  "2001:db8::1"
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end

shared_examples_for "aaaa mutually exclusive" do
  it "should be mutually exclusive with AAAA records" do
    params[:aaaa] =  "2001:db8::1"
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /mutual/)
  end
end

shared_examples "aaaa record" do
  let(:params) {{ :name => "test.example.com", :aaaa => "2001:db8::1" }}
  
  include_examples "resource record"
end