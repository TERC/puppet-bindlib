Puppet::Type.type(:dns_zone).provide(:zone_file, :parent => Puppet::Type.type(:file).provider(:posix)) do
  confine :feature => :posix
  
  def validate
  end
  
end