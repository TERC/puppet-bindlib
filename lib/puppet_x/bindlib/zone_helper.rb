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
    module ZoneHelper
      
    end
  end
end