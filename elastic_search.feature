@application_server @app_server
Feature: Elastic Search

  Scenario: is installed with plugins n' all

    * Files exist:
      | c:\elastic_search\bin\elasticsearch.bat |
      | c:\elastic_search\plugins\bigdesk       |
      | c:\elastic_search\plugins\head          |

  Scenario: it is running

    * curl localhost:9200
    * Output contains "You Know, for Search"

