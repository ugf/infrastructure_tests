@application_server
Feature: User Created

  Scenario: User exists

    * $ net user #{ENV['windows/new_user_name']}

    * Output contains "#{ENV['windows/new_user_name']}"


  Scenario: User password does not expire

    * $ net user #{ENV['windows/new_user_name']} | Find "Account expires"

    * Output contains "never"