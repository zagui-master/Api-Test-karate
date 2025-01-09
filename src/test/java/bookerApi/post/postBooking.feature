Feature: "Como usuario, quiero verificar el comportamiento de la API al crear nuevos registros,
utilizando tanto datos válidos como inválidos, para asegurarme de que el sistema maneje correctamente ambos casos


  Background:
    #* def postDataRequest = read('classpath:bookerApi/post/postDataRequest.json')
    # * def postDataResponse = read('classpath:bookerApi/post/postDataResponse.json')
    * call read('classpath:bookerApi/helpers/generateTestData.feature')
    * def postRequest = dataRequest
    * def postRequestNullValue = dataRequestNullValue
    * def postRequestPartialValues = dataRequestPartialValues
    * def postRequestExtraValues = dataRequestExtraValues
    * def postResponse = dataResponse
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario:Verificar que se puede crear un nuevo registro exitosamente con datos válidos
    Given path '/booking'
    And request postRequest
    When method POST
    Then status 200
    And match response == "#object"
    And match response == dataResponse

  @ignore
  Scenario:Verificar que se obtiene un código de error HTTP 404 al intentar crear un registro con un path incorrecto
    Given path '/example'
    And request postRequest
    When method POST
    Then status 404
    And match response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 500 al intentar crear un registro con datos nulos
    Given path '/booking'
    And request postRequestNullValue
    When method POST
    Then status 500
    And match response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 500 al intentar crear un registro con datos incompletos
    Given path '/booking'
    And request postRequestPartialValues
    When method POST
    Then status 500
    And match response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 500 al intentar crear un registro con datos extra
    Given path '/booking'
    And request postRequestExtraValues
    When method POST
    Then status 500
    And match response != "#object"

