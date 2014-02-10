# Keep all of our constants in one place
# Comprimise I came up with to keep the type non-horrid
module Puppet_X
  module Bindlib
    module Constants
      # Wrap around resolv for now
      IPV4_REGEX = ::Resolv::IPv4::Regex
      IPV6_REGEX = ::Resolv::IPv6::Regex
      
      # Our hostname regex
      HOSTNAME_REGEX = /^(([a-zA-Z0-9][a-zA-Z0-9\-]{0,62})\.)+([a-zA-Z0-9][a-zA-Z0-9\-]{0,62})[\.]?$/
      
      # Example valid records for each validation type
      VALID_RECORD_LOOKUP = {
        :ipv4             => "192.168.0.1",
        :ipv6             => "2001:db8::1",
        :hostname         => "test.example.com",
        :hostnameabsolute => "test.example.com.",
        :mx               => { :value => "mx.example.com.", :priority => 10 },
      }  
      
      RECORD_LOOKUP_TABLE = {  
        :a => {
          :desc       => "",
          :validation => "ipv4",
          :exclusions => [ :cname, :ns, :ptr ]
        }, 
        :aaaa => {
          :desc       => "",
          :validation => "ipv6",
          :exclusions => [ :cname, :ns, :ptr  ]
        },
        :cname => {
          :desc       => "",
          :validation => "hostname",
          :exclusions => [ :a, :aaaa, :ptr, :ns, :mx ]
        },
        :ns => {
          :desc       => "",
          :validation => "hostname",
          :exclusions => [ :a, :aaaa, :cname, :ptr ]
        },
        :mx => {
          :desc       => "",
          :validation => "mx",
          :munge      => "mx",
          :exclusions => [ :cname, :ptr ]
        },
        :ptr => {
          :desc       => "",
          :validation => "hostname",
          :exclusions => [ :a, :aaaa, :cname, :ns, :mx ]
        }
      }
      
      # What to magic MX record priority to if nothing specified
      DEFAULT_MX_PRIORITY = 10
      
      # Sugar
      RECORD_TYPES = Puppet_X::Bindlib::Constants::RECORD_LOOKUP_TABLE.keys 
    end
  end
end
