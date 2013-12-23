require 'puppet/type/file'
require 'puppet/util/checksums'

# Wrapper for resource records.  Extends file resource.
Puppet::Type.newtype(:zone_file, :parent => Puppet::Type::File) do
  @doc = <<-'EOT'
    
  EOT
  
  # Ignore rather than include in case the base class is messed with.  
  # Note that the parameters defined locally don't actually exist yet until this block is evaluated so to
  # act based on that kind of introspection you would need to move all of this into another file
  # that gets required after this block.
  IGNORED_PARAMETERS = [ :backup, :recurse, :recurselimit, :force, 
                         :ignore, :links, :purge, :source, :sourceselect, :show_diff,
                         :provider, :checksum, :type, :replace ]
  IGNORED_PROPERTIES = [ :ensure, :target, :content ]
    
  # Finish up extending the File type - define parameters and properties
  # that aren't ignored and aren't otherwise defined.
    
  # Parameters - appear to require a lookup
  Puppet::Type::File.parameters.each do |inherit|
    unless IGNORED_PARAMETERS.include?(inherit)
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
    unless IGNORED_PROPERTIES.include?(inherit.name)
      newproperty(inherit.name.to_sym, :parent => inherit) do
        desc inherit.doc
      end
    end
  end
    
  # Need to override the following two functions in order to
  # ignore recurse and backup parameters
  def bucket        # to ignore :backup
    nil
  end
  
  def eval_generate # to ignore :recurse
    return []
  end

  # Our code begins
  ensurable
    
  # Actual file content
  newproperty(:content) do
    desc <<-'EOT'
      The desired contents of a file, as a string. This attribute is mutually
      exclusive with `source`.
    EOT
    include Puppet::Util::Checksums
      
    # Convert the current value into a checksum so we don't pollute the logs
    def is_to_s(value)
      md5(value)
    end
  
    # Convert what the value should be into a checksum so we don't pollute the logs
    def should_to_s(value)
      md5(value)
    end
  end
  
  # Parse the file content for the serial
  newproperty(:current_serial) do
    # Read only.  We want to read it from the file but not allow it to be set
    # 
  end
  
  # Parameters 
  newparam(:include) do
    desc <<-'EOT'
      $INCLUDE statements to insert at end of file.
    EOT
  end
  
  newparam(:origins) do
    
  end
  
  newparam(:serial) do
    # defaultto auto
  end
  
  newparam(:ttl) do
    desc <<-'EOT'
      Equivalent to $TTL.  Either numeric or a hash
    EOT
  end
  
  newparam(:views) do
  
  end
  
  # Generates content
  def should_content # Ape the name from property::should
    return @should_content if @should_content # Only do this ONCE
    @should_content = ""
  end
  
  validate do
    
  end
end