Feature: Elastic Search

  Scenario: is installed with plugins n' all

    * Files exist:
      | c:\elastic_search\bin\elasticsearch.bat |
      | c:\elastic_search\plugin\bigdesk        |
      | c:\elastic_search\plugin\head           |

  Scenario: it is running

    * curl localhost:9200
    * Output contains "operational"

