Feature: "Como usuario, quiero verificar el comportamiento de la API al crear nuevos registros,
utilizando tanto datos válidos como inválidos, para asegurarme de que el sistema maneje correctamente ambos casos


  Background:
    * def postDataRequest = read('classpath:bookerApi/post/postDataRequest.json')
    * def postDataResponse = read('classpath:bookerApi/post/postDataResponse.json')
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario:Verificar que se puede crear un nuevo registro exitosamente con datos válidos
    Given path '/booking'
    And request postDataRequest.dataOk
    When method POST
    Then status 200
    * def json_response = response
    And match json_response == "#object"
    And match json_response == postDataResponse
    * def bookingId = json_response.bookingid
    * print response

  Scenario:Verificar que se obtiene un código de error HTTP 404 al intentar crear un registro con un path incorrecto
    Given path '/example'
    And request postDataRequest
    When method POST
    Then status 404
    * def json_response = response
    And match json_response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 500 al intentar crear un registro con datos nulos
    Given path '/booking'
    And request postDataRequest.nullValues
    When method POST
    Then status 500
    * def json_response = response
    And match json_response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 500 al intentar crear un registro con datos incompletos
    Given path '/booking'
    And request postDataRequest.imcomplete
    When method POST
    Then status 500
    * def json_response = response
    And match json_response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 500 al intentar crear un registro con datos extra
    Given path '/booking'
    And request postDataRequest.extra
    When method POST
    Then status 500
    * def json_response = response
    And match json_response != "#object"

