Then /^Powershell has modules:$/ do |modules|

  modules_dir = "/windows/sysnative/WindowsPowershell/v1.0/modules"

  modules.raw.flatten.each do |m|
    Dir.should exist "#{modules_dir}/#{m}"
  end
end