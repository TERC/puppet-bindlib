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
        
      end
    end
  end
  
  # Not sure if this is really needed
  #newparam(:type) do
  #  defaultto do
  #    "IN"
  #  end
  #end
  
  newparam(:origin) do
    # Default to parsing out the name (Needs improvement)
    defaultto do
      raise ArgumentError, "No origin defined and record is neither an IP nor FQDN" unless @resource[:name].include?(".")
      @resource[:name].gsub(/^[^.]+\./,'')
    end
    
    validate do |value|
      if @resource[:ptr]
      else
      end
    end
    
    # Automatically fix up the origin if it's a PTR record
    munge do
      if @resource[:ptr]
        
      end
    end
  end


  VALID_HOSTNAME = /^(([a-zA-Z0-9][a-zA-Z0-9\-]{0,62})\.)+([a-zA-Z0-9][a-zA-Z0-9\-]{0,62})[\.]?$/
  # Between 0 and 63 characters
  # A-Z,a-z,0-9 and hyphens valid(but can not start with a hyphen)
  # We reject
  
  newparam(:a) do
    desc "Address record per RFC1035"
    validate do |value|
      [ :cname, :ptr, :ns ].each do |exclusion|
        raise ArgumentError, "A records are mutually exclusive with #{exclusion} records" if @resource[exclusion]
      end
      
      raise ArgumentError, "#{value} is not a valid IP address" if !(value =~ ::Resolv::IPv4::Regex)
    end
  end
  
  newparam(:aaaa) do
    desc "IPv6 address record per RFC3596"
    validate do |value|
      [ :cname, :ptr, :ns ].each do |exclusion|
        raise ArgumentError, "AAAA records are mutually exclusive with #{exclusion} records" if @resource[exclusion]
      end
      
      raise ArgumentError, "#{value} is not a valid IP address" if !(value =~ ::Resolv::IPv6::Regex)
    end
  end
  
  newparam(:cname) do
    desc "Canonical name record per RFC1035"
    validate do |value|
      [ :a, :aaaa, :ns, :ptr, :mx ].each do |exclusion|
        raise ArgumentError, "CNAME records are mutually exclusive with #{exclusion} records" if @resource[exclusion]
      end
      
      raise ArgumentError, "#{value} is not a valid hostname" if !(value =~ VALID_HOSTNAME)
      
      warn("#{value} is not absolute") if !(::Resolv::DNS::Name.create(value).absolute?)
    end
  end
  
  newparam(:mx) do
    desc "Mail exchange record per RFC1035"
    
    validate do |value|
      [ :cname, :ptr, :ns ].each do |exclusion|
        raise ArgumentError, "NS records are mutually exclusive with #{exclusion} records" if @resource[exclusion]
      end
      
      if value.is_a? Hash
        raise ArgumentError, "Must specify a value"    unless value[:value]    or value["value"]
        raise ArgumentError, "Must specify a priority" unless value[:priority] or value["priority"]
        
        testvalue = value["value"]
        testvalue = value[:value] if value[:value]
          
        raise ArgumentError, "#{testvalue} is not a valid fqdn" if !(testvalue =~ VALID_HOSTNAME)
        warn("#{testvalue} is not absolute") if !(::Resolv::DNS::Name.create(testvalue).absolute?)
        
        testvalue = value["priority"]
        testvalue = value[:priority] if value[:priority]
        
        raise ArgumentError, "#{testvalue} is not a valid priority" if !(testvalue =~ //)
      elsif value.is_a? Array
        raise ArgumentError, "Array is empty" if value.empty?
        value.each do |val|
          raise ArgumentError, "#{val} is not a hash" unless val.is_a? Hash
          raise ArgumentError, "Must specify a value"    unless val[:value]    or val["value"]
          raise ArgumentError, "Must specify a priority" unless val[:priority] or val["priority"]
                  
          testvalue = val["value"]
          testvalue = val[:value] if val[:value]
                    
          raise ArgumentError, "#{testvalue} is not a valid fqdn" if !(testvalue =~ VALID_HOSTNAME)
          warn("#{testvalue} is not absolute") if !(::Resolv::DNS::Name.create(testvalue).absolute?)
                  
          testvalue = val["priority"]
          testvalue = val[:priority] if val[:priority]
                  
          raise ArgumentError, "#{testvalue} is not a valid priority" if !(testvalue =~ //)
        end
      else
        # Validate as if value, default to 10 and munge in the right stuff later
        raise ArgumentError, "#{value} is not valid" if !(value =~ VALID_HOSTNAME)
      end
    end
    
    # Fix up strings to sym
    munge do
      
    end
  end
  
  newparam(:ns) do
    desc "Name server record per RFC1035"
    validate do |value|
      [ :cname, :a, :aaaa, :ptr, :mx ].each do |exclusion|
        raise ArgumentError, "NS records are mutually exclusive with #{exclusion} records" if @resource[exclusion]
      end
      
    end
  end
  
  newparam(:ptr) do
    desc "Pointer record per RFC1035"
    validate do |value|
      TYPES.select{ |type| type != :ptr }.each do |exclusion|
        raise ArgumentError, "PTR records are mutually exclusive with #{exclusion} records" if @resource[exclusion]
      end
      
      raise ArgumentError, "#{value} is not a valid CNAME" if !(value =~ VALID_HOSTNAME)
    end
  end
  
  validate do

  end
end