@application_server
Feature: Chrome

  Scenario: is installed

    * File exists "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

  Scenario: has registry setup

    * Registry "HKEY_LOCAL_MACHINE\Software\Policies\Google\Update" has:
      | key                          | value |
      | AutoUpdateCheckPeriodMinutes | 0     |

    * Registry "HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome" has:
      | key                          | value |
      | HomepageIsNewTabPage         | 1     |
      | RestoreOnStartup             | 0     |
      | DefaultBrowserSettingEnabled | 0     |
      | DefaultSearchProviderEnabled | 0     |