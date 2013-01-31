Then /^Powershell has modules:$/ do |modules|
  p modules_dir = "#{ENV['windir']}\\system32\\WindowsPowershell\\v1.0\\modules"

  modules.raw.each do |m|
    p "#{modules_dir}\\#{m[0]}"
    Dir.should exist "#{modules_dir}\\#{m[0]}"
  end
end