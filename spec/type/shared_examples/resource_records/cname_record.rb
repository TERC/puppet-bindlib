shared_examples "cname record" do
  let(:params) {{ :name => "test.example.com", :cname => "test2.example.com." }}
end