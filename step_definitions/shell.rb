def interpolate(string)
  eval '"' + string + '"'
end

def cmd(command)
  @output = `#{interpolate command}`.downcase
end

Then /^Path contains "([^"]*)"$/ do |dir|
  cmd('set path').should include dir.downcase
end

Then /^\$ (.*?)$/ do |command|
  cmd command
end

Then /^\$:$/ do |commands|
  cmd commands.raw.flatten.join ' '
end

Then /^Output contains "([^"]*)"$/ do |text|
  @output.downcase.should include text.downcase
end

Then /^\| find "([^"]*)"$/ do |text|
  @output.should include text.downcase
end

Then /^Output contains:$/ do |lines|
  lines.raw.each do |line|
    @output.should include line[0].downcase
  end
end
