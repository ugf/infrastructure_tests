require_relative '../fixtures/registry'

def verify_key_exist(key)
  fail "did not find key #{key}" unless Registry.key_exists? key
end

Then /^Registry key exists "([^"]*)"$/ do |key|
  verify_key_exist key
end

Then /^Registry "([^"]*)" has:$/ do |path, expected_values|
  verify_key_exist path

  actual_values = Registry.get_values path

  expected_values.hashes.each do |expected|

    actual_value = actual_values.find { |x| x[0] == expected['key']}

    fail "missing key #{expected['key']}" unless actual_value

    fail "expected #{expected['key']} to be #{expected['value']} but was #{actual_value[2]}" \
      unless expected['value'] == actual_value[2].to_s
  end

end