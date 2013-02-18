@application_server
Feature: Firewall

  Scenario: Is Stopped

    * $ powershell -command "(Get-Service MpsSvc).Status"

    * Output contains "Stopped"