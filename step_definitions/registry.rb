require_relative '../fixtures/registry'

Then /^Registry key exists "([^"]*)"$/ do |key|
  fail "did not find key #{key}" unless Registry.key_exists? key
end