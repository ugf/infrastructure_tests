@application_server
Feature: 7zip

  Scenario: is installed

    * File exists "c:\Program Files (x86)\7-zip\7z.exe"

  Scenario: is in the path

    * Path contains "c:\Program Files (x86)\7-zip"
