@application_server @app_server
Feature: IIS

  Scenario: Is installed

    * $ iisreset /status
    * | find "( W3SVC ) : Running"
