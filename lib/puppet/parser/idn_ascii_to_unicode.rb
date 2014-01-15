require 'puppet/parser/functions'

# Included for completeness really.
Puppet::Parser::Functions.newfunction(:idn_ascii_to_unicode,
                                      :arrity => 3,
                                      :doc => <<-'EOS'
  Converts ascii punycode back to unicode per RFC3492
EOS
) do |args|

end