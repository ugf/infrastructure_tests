Before '@route53' do
  if ENV['route53/domain'].nil? || ENV['route53/domain'].empty?
    puts 'should not use domain for route53'
    ip = ENV['route53/ip'].split '.'
    ENV['route53/prefix'] ||= ip[0]
    ENV['route53/domain'] ||= ip[1..-1].join '.'
  end
end