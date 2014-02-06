# Not sure if puppet_x is in the loadpath so we
# make sure we load things
begin
  require 'puppet_x/bindlib/constants'
rescue LoadError => e
  loadpath = Pathname.new(__FILE__).parent.parent.parent
  require File.join(loadpath, 'puppet_x/bindlib/constants')
end

# Validations may wind up reused a lot, so we split them off.
# Not really appropriate for a gem so we do it as a Puppet Extension, using the PuppetX convention
module Puppet_X
  module Bindlib
    module Validations
      # Sweet, sweet sugar
      def valid_ipv4?(value)
        (value =~ ::Puppet_X::Bindlib::Constants::IPV4_REGEX)
      end
      
      def valid_ipv6?(value)
        (value =~ ::Puppet_X::Bindlib::Constants::IPV6_REGEX)
      end
      
      def valid_hostname?(value)
        (value =~ ::Puppet_X::Bindlib::Constants::HOSTNAME_REGEX)
      end
      
      def is_absolute?(value)
        (::Resolv::DNS::Name.create(value).absolute?)
      end
      
      # Sugar for sugar
      def validate_record(type, val)
        ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:exclusions].each do |exclude|
          raise ArgumentError, "#{type} is mutually exclusive with #{exclude}" if @resource[exclude] 
        end
        case ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:validation]
        when "ipv4"
          raise ArgumentError, "#{val} is not a valid IPV4 address" unless valid_ipv4?(val)
        when "ipv6"
          raise ArgumentError, "#{val} is not a valid IPV6 address" unless valid_ipv6?(val)
        when "hostname"
          raise ArgumentError, "#{val} is not a valid hostname" unless valid_hostname?(val)
        when "hostnameabsolute"
          raise ArgumentError, "#{val} is not a valid hostname" unless valid_hostname?(val)
          warn("#{val} is not absolute") unless is_absolute?(val)
        when "mx"
          validate_mx(val)
        else
          raise ArgumentError, "Unknown validation #{validation} for value #{val}"
        end
      end
      
      # Mx records are special
      def validate_mx_hash(val)
        value = val["value"]
        value = val[:value] if val[:value]
        
        priority = val["priority"]
        priority = val[:priority] if val[:priority]
          
        raise ArgumentError, "#{value} is not a valid hostname" unless valid_hostname?(value)
        warn("#{value} is not absolute") unless is_absolute?(value)   
      end
        
      def validate_mx(value)
        if value.is_a? Array
          raise ArgumentError, "value can't be empty" if value.empty?
          value.each do |val|
            raise ArgumentError, "value must be an array of hashes" unless val.is_a? Hash
            validate_mx_hash(val)
          end
        elsif value.is_a? Hash
          validate_mx_hash(value)
        else
          raise ArgumentError, "#{value} is not a valid hostname" unless valid_hostname?(value)
        end
      end
    end
  end
end