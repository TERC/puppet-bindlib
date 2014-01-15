require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:idn_unicode_to_ascii,
                                      :arrity => 3,
                                      :doc => <<-'EOS'
  Converts unicode to ascii puny code per RFC3492
EOS
) do |args|

end