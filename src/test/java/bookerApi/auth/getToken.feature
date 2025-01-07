@ignore
Feature:Get authentication token

  Background:

    * def credentials = read('classpath:bookerApi/auth/credentials.json')
    * url baseUrl
    * path '/auth'
    * header Content-Type = 'application/json'

  Scenario: Get token
    Given request credentials
    When method POST
    Then status 200
    And response.token == '#string'
    * def token = response.token
    * def defaultToken = "YWRtaW46cGFzc3dvcmQxMjM="
