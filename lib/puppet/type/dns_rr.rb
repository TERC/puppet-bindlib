# Not sure if puppet_x is in the loadpath so we
# make sure we load things
begin
  require 'puppet_x/bindlib/resource_helper'
rescue LoadError => e
  loadpath = Pathname.new(__FILE__).parent.parent.parent
  require File.join(loadpath, 'puppet_x/bindlib/resource_helper')
end

Puppet::Type.newtype(:dns_rr) do
  desc <<-'EOT'
    A DNS Resource Record
  EOT
  
  newparam(:name) do
    isnamevar 
  end
  
  newparam(:owner) do
    desc "The owner of the record, defaults to the name of the puppet resource"
    defaultto do
      @resource[:name]
    end
    
    validate do |value|
      if @resource[:ptr]
        
      else
        raise ArgumentError, "Invalid owner" unless !!(value =~ /^[a-zA-Z0-9][a-zA-Z0-9\-]{0,62}/)
      end
    end
  end

  newparam(:origin) do
    # Attempt to be helpful by parsing out the origin from the resource name
    defaultto do
      raise ArgumentError, "No origin defined and resource name is neither an IP nor FQDN" unless @resource[:name].include?(".")
      @resource[:name].gsub(/^[^.]+\./,'')
    end
    
    validate do |value|
      if @resource[:ptr]
      else
      end
    end
    
    # Automatically fix up the origin if it's a PTR record
    #munge do
    #  if @resource[:ptr]
         
    #  end
    #end
  end

  # Most of these are near identical so we utilize some metaprogramming
  # See lib/puppet_x/bindlib
  ::Puppet_X::Bindlib::Constants::RECORD_TYPES.each do |type|
    newparam(type) do
      include ::Puppet_X::Bindlib::ResourceHelper
      desc ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:desc]

      validate do |value|
        validate_record(type, value)
      end
      
      munge do |value|
        munge_record(type, value)
      end
    end
  end
end
