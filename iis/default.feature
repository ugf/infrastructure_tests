Feature: IIS

  Scenario: Is installed

    * $ dism /online /get-features /format:table | find "Enabled"
    * Output contains:
      |IIS-WebServerRole|
      |IIS-WebServer    |
