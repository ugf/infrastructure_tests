@application_server
Feature: NewGen sts website

  Scenario: sts_website minify conn

    * $ type c:\\websites\\sts_website\\web.config
    * Output contains:
      | compilation debug="false" targetFramework="4.5" />             |
      | dotless minifyCss="true" cache="true" web="true" debug="false" |

  Scenario: sts_website database conn

    * $:
      | type c:\\websites\\sts_website\\web.config |
      | \| find "name=""SystemConnection"""        |
    * Output contains:
      | Data Source=#{ENV['newgen/database_server']} |
      | Integrated Security=false                    |
      | User Id=#{ENV['newgen/database_user']}       |
      | Password=#{ENV['newgen/database_password']}  |
