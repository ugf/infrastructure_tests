@application_server
Feature: NewGen

  Scenario: Websites copied

    * Directory exists "C:\websites\main_website"
    * Directory exists "C:\websites\sts_website"


  Scenario: Certificate created

    * $ powershell -command "Get-ChildItem -Recurse Cert: | Where-Object {$_.Subject -like '*passivests*'}"
    * Output contains "Directory: Microsoft.PowerShell.Security\\Certificate::LocalMachine\\Root"


  Scenario: Access granted to certificate

    * $ "C:\\Program Files (x86)\\Windows Resource Kits\\Tools\\winhttpcertcfg" -l -c LOCAL_MACHINE\\My -s passivests
    * Output contains "NETWORK SERVICE"

  Scenario: main_website elmah conn

    * $ type c:\\websites\\main_website\\web.config | find "name=""elmah"" connectionString="

    * Output contains:
      | "Data Source=#{ENV['elmah/logging_server']}" |
      | Initial Catalog=HealthCheck                  |
      | Integrated Security=false                    |
      | "User Id=#{ENV['elmah/database_user']}"      |
      | "Password=#{ENV['elmah/database_password']}" |
      | MultipleActiveResultSets=True                |

    * $ type c:\\websites\\main_website\\web.config | find "key = "searchHost""

    * Output contains:
      | value = "localhost" |

    * $ type c:\\websites\\main_website\\web.config | find "key = "searchPort""

    * Output contains:
      | value = "9200" |

    * $ type c:\\websites\\main_website\\web.config | find "compilation debug="

    * Output contains:
      | compilation debug="false" targetFramework="4.5" /> |

    * $ type c:\\websites\\main_website\\web.config | find "dotless minifyCss="

    * Output contains:
      | dotless minifyCss="true" cache="true" web="true" debug="false" |

    * $ type c:\\websites\\sts_website\\web.config | find "%route53/prefix%.%route53/domain%:80"

    * Output contains:
      | "#{ENV['route53/prefix']}.#{ENV['route53/domain']}:80" |

    * $ type c:\\websites\\sts_website\\web.config | find "%route53/prefix%.%route53/domain%:81"

    * Output contains:
      | "#{ENV['route53/prefix']}.#{ENV['route53/domain']}:81" |

  Scenario: sts_website elmah conn

    * $ type c:\\websites\\sts_website\\web.config | find "name=""elmah"" connectionString="

    * Output contains:
      | "Data Source=#{ENV['elmah/logging_server']}" |
      | Initial Catalog=HealthCheck                  |
      | Integrated Security=false                    |
      | "User Id=#{ENV['elmah/database_user']}"      |
      | "Password=#{ENV['elmah/database_password']}" |
      | MultipleActiveResultSets=True                |

    * $ type c:\\websites\\main_website\\web.config | find "key = "searchHost""

    * Output contains:
      | value = "localhost" |

    * $ type c:\\websites\\main_website\\web.config | find "key = "searchPort""

    * Output contains:
      | value = "9200" |

    * $ type c:\\websites\\main_website\\web.config | find "compilation debug="

    * Output contains:
      | compilation debug="false" targetFramework="4.5" /> |

    * $ type c:\\websites\\main_website\\web.config | find "dotless minifyCss="

    * Output contains:
      | dotless minifyCss="true" cache="true" web="true" debug="false" |

    * $ type c:\\websites\\sts_website\\web.config | find "%route53/prefix%.%route53/domain%:80"

    * Output contains:
      | "#{ENV['route53/prefix']}.#{ENV['route53/domain']}:80" |

    * $ type c:\\websites\\sts_website\\web.config | find "%route53/prefix%.%route53/domain%:81"

    * Output contains:
      | "#{ENV['route53/prefix']}.#{ENV['route53/domain']}:81" |
