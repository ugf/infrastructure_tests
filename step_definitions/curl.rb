Then /^curl (.*)$/ do |url|
  @output = Curl.get url
end