@application_server @route53
Feature: NewGen

  Scenario: Websites copied

    * Directory exists "C:\websites\main_website"
    * Directory exists "C:\websites\sts_website"

  Scenario: Certificate created

    * $ powershell -command "Get-ChildItem -Recurse Cert: | Where-Object {$_.Subject -like '*passivests*'}"
    * Output contains "Directory: Microsoft.PowerShell.Security\\Certificate::LocalMachine\\Root"

  Scenario: Access granted to certificate

    * $:
      | "C:\Program Files (x86)\Windows Resource Kits\Tools\winhttpcertcfg" |
      | -l -c LOCAL_MACHINE\My -s passivests                                |
    * Output contains "NETWORK SERVICE"

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

  Scenario: IIS websites started

    * $:
      | %windir%\\SysNative\\WindowsPowerShell\\v1.0\\powershell -command " |
      | Set-ExecutionPolicy RemoteSigned -force;                            |
      | import-module WebAdministration;                                    |
      | Get-Item IIS:\\AppPools\\*                                          |
      | "                                                                   |
    * Output contains:
      | main_website .* Started |
      | sts_website .* Started  |