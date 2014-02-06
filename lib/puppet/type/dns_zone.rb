require 'puppet/type/file'
require 'puppet/util/checksums'

Puppet::Type.newtype(:dns_zone) do
  @doc = <<-'EOT'
    
  EOT

  newparam(:zone) do
    isnamevar
  end
  
  def gather_resources
    
  end
  
  # Update our serial on a refresh
  def refresh
    @increment_serial = true
  end
end