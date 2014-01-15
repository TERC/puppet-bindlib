# Create a valid record and expect everything to be peachy(the default)
shared_examples_for "a not mutually exclusive" do
  it "should not be mutually exclusive with A records" do
    params[:a] = "192.168.0.1"
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end

# Create a valid A record, expecting an error on resource validation
shared_examples_for "a mutually exclusive" do
  it "should be mutually exclusive with A records" do
    params[:a] = "192.168.0.1"
    expect {
      testobject.new(params)
    }.to raise_error(Puppet::Error, /mutually exclusive/)
  end
end

#
shared_examples "a record" do
  let(:params)    {{ :name => "test.example.com", :a => "192.168.0.1" }}
  let(:testparam) { :a }
    
  include_examples "resource record"
  include_examples "ipv4 validations"
  
  # TYPES is defined for validation shorthand purposes in lib/puppet/type/dns_rr.rb
  (TYPES - [:cname, :ptr, :ns, :a ]).each do |include|
    begin
      include_examples "#{include} not mutually exclusive"
    rescue ArgumentError => e
      raise e unless !!(e.to_s =~ /Could not find shared examples/)
      it "a shared_example named \"#{include} not mutually exclusive\" should be present"
    end
  end
    
  [:cname, :ptr, :ns ].each do |exclude|
    begin
      include_examples "#{exclude} mutually exclusive"
    rescue ArgumentError => e
      raise e unless !!(e.to_s =~ /Could not find shared examples/)
      it "a shared_example named \"#{exclude} not mutually exclusive\" should be present"
    end
  end
end