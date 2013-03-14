@database_server
Feature: SQL Server

  Scenario: Is installed

    * $:
      | sqlcmd -E -Q "     |
      | select name        |
      | from sys.databases |
      | "                  |
    * Output contains:
      | master |
      | tempdb |
      | model  |
      | msdb   |