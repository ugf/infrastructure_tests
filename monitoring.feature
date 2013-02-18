@application_server
Feature: Monitoring

  Scenario: is installed

    * File exists "C:\Program Files (x86)\RightScale\RightLinkService\scripts\monitoring.rb"

    * Directory exists "C:\Program Files (x86)\RightScale\RightLinkService\scripts\lib"
