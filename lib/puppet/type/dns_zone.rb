require 'puppet/type/file'
require 'puppet/util/checksums'

begin
  require 'puppet_x/bindlib/zone_helper'
rescue LoadError => e
  loadpath = Pathname.new(__FILE__).parent.parent.parent
  require File.join(loadpath, 'puppet_x/bindlib/zone_helper')
end

Puppet::Type.newtype(:dns_zone) do
  @doc = <<-'EOT'
    
  EOT

  newparam(:name) do
    isnamevar
  end
  
  newparam(:zone) do
    #isnamevar
  end

  # Magic
  
  def gather_resources
    
  end
  
  # Update our serial on a refresh
  def refresh
    @increment_serial = true
    # Time.new.strftime("%Y%m%d00").to_i
  end
  
  validate do
  end
end