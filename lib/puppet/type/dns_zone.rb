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

  # Inherit certain things from file
  # Parameters - appear to require a lookup
  Puppet::Type::File.parameters.each do |inherit|
    if ::Puppet_X::Bindlib::Constants::INHERITED_FILE_PARAMS.include?(inherit)
      klass = "Puppet::Type::File::Parameter#{inherit.to_s.capitalize}"
      begin
        newparam(inherit, :parent => self.const_get(klass)) do
          desc self.const_get(klass).doc
        end
      rescue 
        warning "Inheritance assumption case problem: #{klass} undefined but not ignored."
      end
    end
  end
    
  # Properties are easier as the class is in the instance variable
  Puppet::Type::File.properties.each do |inherit|
    if ::Puppet_X::Bindlib::Constants::INHERITED_FILE_PROPERTIES.include?(inherit.name)
      newproperty(inherit.name.to_sym, :parent => inherit) do
        desc inherit.doc
      end
    end
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