@database_server
Feature: SQL Server

  Scenario: Is installed

    * $:
      | sqlcmd -U sa -P Answer_42 -E -Q  |
      | "select name from sys.databases" |
    * Output contains:
      | master |
      | tempdb |
      | model  |
      | msdb   |