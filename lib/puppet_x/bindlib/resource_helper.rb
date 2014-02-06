# Not sure if puppet_x is in the loadpath so we
# make sure we load things
begin
  require 'puppet_x/bindlib/validations'
  require 'puppet_x/bindlib/constants'
rescue LoadError => e
  loadpath = Pathname.new(__FILE__).parent.parent.parent
  require File.join(loadpath, 'puppet_x/bindlib/constants')
  require File.join(loadpath, 'puppet_x/bindlib/validations')
end

module Puppet_X
  module Bindlib
    module ResourceHelper
      include ::Puppet_X::Bindlib::Validations

      def symify_hash_keys(value)
        return value unless value.is_a? Hash
        value.keys.each do |key|
          if value[key] != value[key.to_sym]
            value[key.to_sym] = value[key] unless value[key.to_sym]
            value.delete(key)
          end
        end
        return value
      end
      
      def munge_to_array_of_hashes(value)
        if value.is_a? Array
          retval = Array.new
          value.each do |val|
            retval.push(symify_hash_keys(val))
          end
          return retval
        elsif value.is_a? Hash
          return [ symify_hash_keys(value) ]
        else
          raise ArgumentError, "Expected array or hash"
        end
      end
      
      def munge_record(type, value)
        case ::Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE[type][:munge]
        when "mx"
          begin
            return munge_to_array_of_hashes(value) 
          rescue ArgumentError => e
            raise e unless !!(e.to_s =~ /Expected array or hash/)
            return [{ :priority => ::Puppet_X::Bindlib::Constants::DEFAULT_MX_PRIORITY, 
                      :value => value }]
          end
        else
          return value
        end
      end
    end
  end
end