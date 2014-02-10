shared_examples "mx record" do
  let(:params) {{ :name => "test.example.com", :mx => "mx.example.com." }}
                         
  it "should accept arrays of mx records" do
    params[:mx] = [ { :priority => "10", :value => "mx1.example.com." }, 
                    { :priority => "15", :value => "mx2.example.com." } ]
    expect {
      testobject.new(params)
    }.not_to raise_error
  end
end