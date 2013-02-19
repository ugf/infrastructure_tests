@application_server
Feature: NewGen

  Scenario: Websites copied

    * Directory exists "C:\websites\main_website"
    * Directory exists "C:\websites\sts_website"


  Scenario: Certificate added

    * $ Get-ChildItem -Recurse Cert: | Where-Object {$_.Subject -like "*passivests*"}
    * Output contains "Directory: Microsoft.PowerShell.Security\Certificate::LocalMachine\Root"


