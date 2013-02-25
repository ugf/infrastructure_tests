@application_server
Feature: NewGen sts website

  Scenario: sts_website elmah conn

    * $:
      | type c:\\websites\\sts_website\\web.config |
      | \| find "name=""elmah"" connectionString=" |
    * Output contains:
      | Data Source=#{ENV['elmah/logging_server']} |
      | Initial Catalog=HealthCheck                |
      | Integrated Security=false                  |
      | User Id=#{ENV['elmah/database_user']}      |
      | Password=#{ENV['elmah/database_password']} |
      | MultipleActiveResultSets=True              |

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
