@logging_server
Feature: Elmah

  Scenario: Is setup in the db

    * $:
      | sqlcmd                               |
      | -S localhost                         |
      | -U #{ENV['elmah/database_user']}     |
      | -P #{ENV['elmah/database_password']} |
      | -Q "                                 |
      | select top 1 Message                 |
      | from HealthCheck.dbo.ELMAH_Error     |
      | "                                    |
    * Output contains "Message"