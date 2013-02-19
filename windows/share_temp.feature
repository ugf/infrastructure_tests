@application_server
Feature: Share temp

  Scenario: Is created

    * $ net use temp

    * Output contains:
      | Share name .* temp           |
      | Path .* c:\temp              |
      | Permission .* Everyone, READ |