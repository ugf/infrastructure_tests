@application_server
Feature: Share temp

  Scenario: Is created

    * $ net share temp

    * Output contains:
      | /Share name .* temp/           |
      | /Permission .* Everyone, READ/ |
      | /Path .* c:\\\\temp/           |
