require 'win32/registry'

registry = Win32::Registry::HKEY_LOCAL_MACHINE

Then /^Registry key exists "([^"]*)"$/ do |key|

  #registry::open(key, 'Alienware') do |x|
  #  pp x
  #end

end