Then /^File exists "([^"]*)"$/ do |file|
  File.should exist file
end

Then /^Files exist:$/ do |files|
end