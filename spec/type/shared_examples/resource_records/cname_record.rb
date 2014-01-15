shared_examples_for "cname not mutually exclusive" do
  it "should not be mutually exclusive with CNAME records" do
    params[:cname] =  "test2.example.com."
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end

shared_examples_for "cname mutually exclusive" do
  it "should be mutually exclusive with CNAME records" do
    params[:cname] =  "test2.example.com."
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /mutual/)
  end
end

shared_examples "cname record" do
  let(:params) {{ :name => "test.example.com", :cname => "test2.example.com." }}
  
  include_examples "resource record"
  
  (TYPES - [ :a, :aaaa, :ptr, :ns, :mx, :cname ]).each do |include|
    include_examples "#{include} not mutually exclusive"
  end
  
  [ :a, :aaaa, :ptr, :ns, :mx ].each do |exclude|
    include_examples "#{exclude} mutually exclusive"
  end
end