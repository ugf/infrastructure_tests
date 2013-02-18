@application_server
Feature: Timezone

  Scenario: Is Eastern Time

    * $ powershell -command "(Get-WMIObject -class Win32_TimeZone -ComputerName '.').Description"

    * Output contains "(UTC-05:00) Eastern Time (US & Canada)"