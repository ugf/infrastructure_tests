@application_server
Feature: Route53

  Scenario: Is Registered

    * $ ping #{ENV['route53/prefix']}.#{ENV['route53/domain']}

    * Output contains "#{ENV['route53/ip']}" unless "#{ENV['route53/domain'].nil? || ENV['route53/domain'].empty?}"