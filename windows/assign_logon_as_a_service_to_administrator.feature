@application_server
Feature: assign logon as a service to administrator

  Scenario: administrator has logon as a service rights

    * $ net localgroup Administrators | find "admin"
    """
    admin
    """

