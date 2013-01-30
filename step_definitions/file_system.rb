Then /^File exists "([^"]*)"$/ do |file|
  File.exist?(file).should be true
end