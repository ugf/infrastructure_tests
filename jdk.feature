@application_server
Feature: jdk

  Scenario: is installed

    * Directory exists "c:\jdk"

  Scenario: is in the path

    * Path contains "c:\jdk"

  Scenario: environment variables created

    * $ set java_home
    * Output contains "JAVA_HOME=c:\jdk"

    * $ set jre_home
    * Output contains "JRE_HOME=c:\jdk"