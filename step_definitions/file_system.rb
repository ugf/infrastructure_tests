Then /^File exists "([^"]*)"$/ do |file|
  File.should exist file
end