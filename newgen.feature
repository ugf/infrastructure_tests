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

  Scenario: elmah conn

    * $ type c:\\websites\\main_website\\web.config | find "name=""elmah"" connectionString="

    * Output contains:
      | "Data Source=#{ENV['elmah/logging_server']}" |
      | Initial Catalog=HealthCheck                  |
      | Integrated Security=false                    |
      | "User Id=#{ENV['elmah/database_user']}"      |
      | "Password=#{ENV['elmah/database_password']}" |
      | MultipleActiveResultSets=True                |

