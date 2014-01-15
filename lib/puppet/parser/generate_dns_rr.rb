require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:generate_dns_rr,
                                      :arrity => 3,
                                      :doc => <<-'EOS'
This function mirrors the $GENERATE directive found in BIND.

EOS
) do |args|

  # And call out to the create_resources function
  # function_create_resources(['databucket', object])
end