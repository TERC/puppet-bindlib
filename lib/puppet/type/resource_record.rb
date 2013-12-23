
Puppet::Type.newtype(:resource_record) do
  desc <<-'EOT'
  EOT
  
  newparam(:origin) do
    
  end

  newparam(:views) do
    
  end

  newparam(:ttl) do
    
  end
     
  [ :a, :ns, :aaaa, :mx ].each do |rr|
    newparam(rr) do
      desc <<-'EOT'
        Corresponds to same named resource record.  See bind ARM for description.
      EOT
    end
  end
  
  validate do
      
  end
end