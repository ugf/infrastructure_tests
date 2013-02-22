def verify(actual, expected)
  should_include expected, actual
rescue
  should_match expected, actual
end

def should_include(expected, actual)
  actual.downcase.should(
    include (interpolate expected).downcase)
end

def should_match(expected, actual)
  actual.should match /#{interpolate expected}/i
end

def interpolate(string)
  return string unless string.match /\#\{.*?\}/
  string = string.gsub '"', '\"'
  eval '"' + string + '"'
end

def cmd(command)
  @output = `#{interpolate command}`
end

Then /^Path contains "([^"]*)"$/ do |dir|
  verify cmd('set path'), dir
end

Then /^\$ (.*?)$/ do |command|
  cmd command
end

Then /^\$:$/ do |commands|
  cmd commands.raw.flatten.join ' '
end

Then /^Output contains "(.*)"$/ do |text|
  verify @output, text
end

Then /^\| find "([^"]*)"$/ do |text|
  verify @output, text
end

Then /^Output contains:$/ do |lines|
  lines.raw.flatten.each { |line| verify @output, line }
end