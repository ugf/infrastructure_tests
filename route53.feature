@application_server @route53
Feature: Route53

  Scenario: Is Registered

    * $ ping #{ENV['route53/prefix']}.#{ENV['route53/domain']}

    * Output contains "#{ENV['route53/ip']}"