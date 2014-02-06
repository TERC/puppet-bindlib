require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'

Dir["./spec/type/shared_examples/*.rb"].sort.each {|f| require f}
Dir["./spec/type/shared_examples/**/*.rb"].sort.each {|f| require f}
Dir["../lib/puppet_x/bindlib/*.rb"].sort.each {|f| require f}