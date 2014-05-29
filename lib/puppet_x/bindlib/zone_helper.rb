begin
  require 'puppet_x/bindlib/constants'
rescue LoadError => e
  loadpath = Pathname.new(__FILE__).parent.parent.parent
  require File.join(loadpath, 'puppet_x/bindlib/constants')
end

module Puppet_X
  module Bindlib
    module ZoneHelper
      
    end
  end
end