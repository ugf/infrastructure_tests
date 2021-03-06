@application_server @app_server
Feature: mssql

  Scenario: native client is installed

    * Registry key exists "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\SQLNCLI10\CurrentVersion"

  Scenario: commandline tool is installed

    * File exists "C:\Program Files\Microsoft SQL Server\100\Tools\Binn\sqlcmd.exe"

  Scenario: path contains

    * Path contains "C:\Program Files\Microsoft SQL Server\100\Tools\Binn"
