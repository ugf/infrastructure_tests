@application_server
Feature: NewGen main website

  Scenario: is installed

    * Directory exists "c:\migration"

  Scenario: migrate config database conn

    * $:
      | type c:\\migration\\*.config |
      | \| find "Data Source="       |
    * Output contains:
      | Data Source=#{ENV['newgen/database_server']} |
      | Integrated Security=false                    |
      | User Id=#{ENV['newgen/database_user']}       |
      | Password=#{ENV['newgen/database_password']}  |