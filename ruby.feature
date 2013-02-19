@application_server
Feature: Ruby

  Scenario: Is Installed

    * $ ruby -v

    * Output contains "ruby "


  Scenario: Has Gem List

    * $ gem list

    * Output contains:
      | amazon-ec2  |
      | bundle      |
      | fog         |
      | rest-client |
      | xml-simple  |
      | rr          |
      | rspec       |
      | simplecov   |
      | cucumber    |


  Scenario: Devkit Exists

    * Directory exists "c:\devkit"