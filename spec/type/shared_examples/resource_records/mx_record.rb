shared_examples_for "mx not mutually exclusive" do
  it "should not be mutually exclusive with MX records" do
    params[:mx] = "mx.example.com."
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end

shared_examples_for "mx mutually exclusive" do
  it "should be mutually exclusive with MX records" do
    params[:mx] = "mx.example.com."
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /mutual/)
  end
end

shared_examples "mx record" do
  let(:params) {{ :name => "test.example.com", :mx   => "mx.example.com." }}
  
  include_examples "resource record"
                         
  it "should accept arrays of mx records" do
    params[:mx] = [ { :priority => "10", :value => "mx1.example.com." }, 
                    { :priority => "15", :value => "mx2.example.com." } ]
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end