@application_server
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

  Scenario: Adds logs folder

    * Directory exists "C:\logs"



