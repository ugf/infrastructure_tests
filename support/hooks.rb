Before '@route53' do
  break unless ENV['route53/domain'].nil?

  ip = ENV['route53/ip'].split '.'
  ENV['route53/prefix'] ||= ip[0]
  ENV['route53/domain'] ||= ip[1..-1].join '.'
end