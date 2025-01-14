  #@ignore
  Feature:Get authentication token

    Background:
      * url baseUrl
      * path '/auth'
      * header Content-Type = 'application/json'

    Scenario: Get token
      #### THE "credential" VARIABLE IS IMPORTED FROM  "karate-config.js".#####
      Given request credential
      When method POST
      Then status 200
      And response.token == '#string'
      * def token = "token=" + response.token
      #karate.configuration('logPrettyRequest', true)