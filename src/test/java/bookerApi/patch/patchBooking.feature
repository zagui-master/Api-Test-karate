Feature:Como usuario, quiero actualizar un registro de reserva mediante el metodo PATCH, utilizando datos válidos e inválidos
para asegurarme de que el sistema maneja correctamente ambos casos

  Background:
    * call read('classpath:bookerApi/auth/getToken.feature')
    * call read('classpath:bookerApi/common/createNewBooking.feature')
    * def patchDataRequest = read('classpath:bookerApi/patch/patchDataRequest.json')
    * def patchDataResponse = read('classpath:bookerApi/patch/patchDataResponse.json')
    * header Content-Type = "application/json"
    * header Accept = "application/json"
    * header Authorization = "Basic " + defaultToken
    * url baseUrl

  Scenario:Verificar que se puede actualizar una reserva exitosamente mediante el metodo PATCH con datos válidos
    Given path 'booking/' + bookingId
    And request patchDataRequest.dataOk
    When method PATCH
    Then status 200
    * def json_response = $
    And match json_response == "#object"
    And match json_response == patchDataResponse


  Scenario:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva con un path incorrecto
    Given path '/example/' + bookingId
    * print bookingId
    And request patchDataRequest.dataOk
    When method PATCH
    Then status 404
    * def json_response = response
    And match json_response != "#object"


  Scenario Outline:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva con un ID de caracteres especiales
    Given path '/booking' + incorrectId
    And request patchDataRequest.dataOk
    When method PATCH
    Then status 404
    * def json_response = response
    And match json_response != "#object"
    Examples:
      | incorrectId |
      | %&/&(//(    |


  Scenario Outline:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva con un ID negativo
    Given path '/booking' + incorrectId
    And request patchDataRequest.dataOk
    When method PATCH
    Then status 404
    * def json_response = response
    And match json_response != "#object"
    Examples:
      | incorrectId |
      | -1562       |


  Scenario:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva sin proporcionar un ID
    Given path '/booking'
    And request patchDataRequest.dataOk
    When method PATCH
    Then status 404
    * def json_response = response
    And match json_response != "#object"


  Scenario:Verificar que se obtiene un código de error HTTP 400 al intentar actualizar una reserva con datos nulos
    Given path '/booking/' + bookingId
    And request patchDataRequest.nullValues
    When method PATCH
    Then status 400
    * def json_response = response
    And match json_response != "#object"


  Scenario:Verificar que se obtiene un código de error HTTP 400 al intentar actualizar una reserva con datos incompletos
    Given path '/booking/' + bookingId
    And request patchDataRequest.imcomplete
    When method PATCH
    Then status 400
    * def json_response = response
    And match json_response != "#object"


  Scenario:Verificar que se obtiene un código de error HTTP 400 al intentar actualizar una reserva con datos extra
    Given path '/booking/' + bookingId
    And request patchDataRequest.extra
    When method PATCH
    Then status 400
    * def json_response = response
    And match json_response != "#object"

