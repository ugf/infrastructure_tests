def cmd(command)
  `#{command}`
end

Then /^Path contains (.*?)$/ do |dir|
  cmd('set path').downcase.should include dir.downcase
end