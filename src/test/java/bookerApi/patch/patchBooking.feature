Feature:Como usuario, quiero actualizar un registro de reserva mediante el metodo PATCH, utilizando datos válidos e inválidos
para asegurarme de que el sistema maneja correctamente ambos casos

  Background:
    * call read('classpath:bookerApi/auth/getToken.feature')
    * call read('classpath:bookerApi/common/createNewBooking.feature')
    * call read('classpath:bookerApi/helpers/generateTestData.feature')
    * def patchRequest = dataRequestPartialValues
    * def patchRequestNullValue = dataRequestNullValue
    * def patchRequestEmpty = dataRequestEmpty
    * def patchRequestExtraValues = dataRequestExtraValues
    * def patchResponse = dataRequest
    * def patchDataRequest = read('classpath:bookerApi/patch/patchDataRequest.json')
    * def patchDataResponse = read('classpath:bookerApi/patch/patchDataResponse.json')
    * header Content-Type = "application/json"
    * header Accept = "application/json"
    * header Authorization = "Basic " + defaultToken
    * url baseUrl


  Scenario:Verificar que se puede actualizar una reserva exitosamente mediante el metodo PATCH con datos válidos
    Given path 'booking/' + bookingId
    And request patchRequest
    When method PATCH
    Then status 200
    And match response == "#object"
    And match response.firstname == patchRequest.firstname
    And match response.lastname == patchRequest.lastname

  Scenario:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva con un path incorrecto
    Given path '/example/' + bookingId
    * print bookingId
    And request patchRequest
    When method PATCH
    Then status 404
    And match response != "#object"

  Scenario Outline:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva con un ID de caracteres especiales
    Given path '/booking' + incorrectId
    And request patchRequest
    When method PATCH
    Then status 404
    And match response != "#object"
    Examples:
      | incorrectId |
      | %&/&(//(    |

  Scenario Outline:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva con un ID negativo
    Given path '/booking' + incorrectId
    And request patchRequest
    When method PATCH
    Then status 404
    And match response != "#object"
    Examples:
      | incorrectId |
      | -1562       |

  Scenario:Verificar que se obtiene un código de error HTTP 404 al intentar actualizar una reserva sin proporcionar un ID
    Given path '/booking'
    And request patchRequest
    When method PATCH
    Then status 404
    And match response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 400 al intentar actualizar una reserva con datos nulos
    Given path '/booking/' + bookingId
    And request patchRequestNullValue
    When method PATCH
    Then status 400
    And match response != "#object"

  Scenario:Verificar que se obtiene un código de error HTTP 400 al intentar actualizar una reserva sin pasarle datos
    Given path '/booking/' + bookingId
    And request patchRequestEmpty
    When method PATCH
    Then status 400
    And match response != "#object"


  Scenario:Verificar que se obtiene un código de error HTTP 400 al intentar actualizar una reserva con datos extra
    Given path '/booking/' + bookingId
    And request patchRequestExtraValues
    When method PATCH
    Then status 400
    And match response != "#object"

