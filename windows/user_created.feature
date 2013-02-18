@application_server
Feature: User Created

  Scenario: User exists

    * $ net user #{ENV['windows/new_user_name']}

    * Output contains "#{ENV['windows/new_user_name']}"

    * Output contains "never"