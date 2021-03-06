Then /^File exists "([^"]*)"$/ do |file|
  File.should exist file
end

Then /^Files exist:$/ do |files|
  files.raw.flatten.each { |file| File.should exist file}
end

Then /^Directory exists "([^"]*)"$/ do |directory|
  Dir.should exist directory
end