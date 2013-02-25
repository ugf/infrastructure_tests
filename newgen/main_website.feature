@application_server
Feature: NewGen main website

  Scenario: main_website elmah conn

    * $:
      | type c:\\websites\\main_website\\web.config |
      | \| find "name=""elmah"" connectionString="  |
    * Output contains:
      | Data Source=#{ENV['elmah/logging_server']} |
      | Initial Catalog=HealthCheck                |
      | Integrated Security=false                  |
      | User Id=#{ENV['elmah/database_user']}      |
      | Password=#{ENV['elmah/database_password']} |
      | MultipleActiveResultSets=True              |

  Scenario: main_website elastic search conn

    * $ type c:\\websites\\main_website\\web.config
    * Output contains:
      | key="searchHost" value="localhost" |
      | key="searchPort" value="9200"      |

  Scenario: main_website minify conn

    * $ type c:\\websites\\main_website\\web.config
    * Output contains:
      | compilation debug="false" targetFramework="4.5"                |
      | dotless minifyCss="true" cache="true" web="true" debug="false" |

  @route53
  Scenario: main_website prefix.domain conn

    * $ type c:\\websites\\main_website\\web.config
    * Output contains:
      | #{ENV['route53/prefix']}.#{ENV['route53/domain']}:80 |
      | #{ENV['route53/prefix']}.#{ENV['route53/domain']}:81 |

  Scenario: main_website database conn

    * $:
      | type c:\\websites\\main_website\\web.config |
      | \| find "name=""SystemConnection"""         |
    * Output contains:
      | Data Source=#{ENV['newgen/database_server']} |
      | Integrated Security=false                    |
      | User Id=#{ENV['newgen/database_user']}       |
      | Password=#{ENV['newgen/database_password']}  |

