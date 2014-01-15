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

  # TYPES is defined for validation shorthand purposes in lib/puppet/type/dns_rr.rb  
  (TYPES - [:cname, :ptr, :ns, :aaaa ]).each do |include|
    include_examples "#{include} not mutually exclusive"
  end
      
  [:cname, :ptr, :ns ].each do |exclude|
    include_examples "#{exclude} mutually exclusive"
  end
end