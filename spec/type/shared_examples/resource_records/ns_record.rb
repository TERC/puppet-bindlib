shared_examples_for "ns not mutually exclusive" do
  it "should not be mutually exclusive with NS records" do
    params[:ns] =  "ns.example.com."
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end

shared_examples_for "ns mutually exclusive" do
  it "should be mutually exclusive with NS records" do
    params[:ns] =  "ns.example.com."
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /mutual/)
  end
end

shared_examples "ns record" do
  let(:params) {{ :name => "test.example.com", :ns => "ns.example.com." }}
  
  include_examples "resource record"
  
  (TYPES -  [ :cname, :a, :aaaa, :ptr, :mx, :ns ]).each do |include|
    include_examples "#{include} not mutually exclusive"
  end
  
  [ :cname, :a, :aaaa, :ptr, :mx ].each do |exclude|
    include_examples "#{exclude} mutually exclusive"
  end
end