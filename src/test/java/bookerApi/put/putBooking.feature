Feature:Como usuario de la plataforma de reservas Booking, quiero verificar que al actualizar un registro mediante el metodo PUT,
el sistema procese correctamente los datos válidos y responda con los códigos de error adecuados cuando los datos sean incorrectos,
incompletos, nulos o extras

  Background:
    * call read('classpath:bookerApi/auth/getToken.feature')
    * call read('classpath:bookerApi/common/createNewBooking.feature')
    * call read('classpath:bookerApi/helpers/generateTestData.feature')
    * def putRequest = dataRequest
    * def putRequestNullValue = dataRequestNullValue
    * def putRequestPartialValues = dataRequestPartialValues
    * def putRequestExtraValues = dataRequestExtraValues
    * def putResponse = putRequest
    # * def putDataRequest = read('classpath:bookerApi/put/putDataRequest.json')
    #  * def putDataResponse = read('classpath:bookerApi/put/putDataResponse.json')
    * header Content-Type = "application/json"
    * header Accept = "application/json"
    * header Authorization = "Basic " + defaultToken
    * url baseUrl

  Scenario:Verificar que al intentar actualizar un registro mediante el metodo PUT con datos correctos, el sistema actualiza los datos exitosamente
    Given path 'booking/' + bookingId
    And request putRequest
    When method PUT
    Then status 200
    And match response == "#object"
    And match response == putResponse

  Scenario:Verificar que al intentar actualizar un registro mediante el metodo PUT con un path incorrecto, se retorna un código de error HTTP 404
    Given path '/example/' + bookingId
    * print bookingId
    And request putRequest
    When method PUT
    Then status 404
    And match response != "#object"

  Scenario Outline:Verificar que al intentar actualizar un regiostro por medio de metodo PUT, con un ID de caracteres especiales, nos retorne un codigo de error HTTP 404
    Given path '/booking' + incorrectId
    And request putRequest
    When method PUT
    Then status 404
    And match response != "#object"
    Examples:
      | incorrectId |
      | %&/&(//(    |

  Scenario Outline:Verificar que al intentar actualizar un regiostro por medio de metodo PUT, con un ID negativo, nos retorne un codigo de error HTTP 404
    Given path '/booking' + incorrectId
    And request putRequest
    When method PUT
    Then status 404
    And match response != "#object"
    Examples:
      | incorrectId |
      | -1562       |

  Scenario: Verificar que al intentar actualizar un regiostro por medio de metodo PUT, sin pasarle un ID, nos retorne un codigo de error HTTP 404
    Given path '/booking'
    And request putRequest
    When method PUT
    Then status 404
    And match response != "#object"

  Scenario:Verificar que al intentar actualizar un regiostro por medio de metodo PUT, con data null, nos retorne un codigo de error HTTP 400
    Given path '/booking/' + bookingId
    And request putRequestNullValue
    When method PUT
    Then status 400
    And match response != "#object"

  Scenario:Verificar que al intentar crear actualizar un regiostro por medio de metodo PUT, con data incompleta, nos retorne un codigo de error HTTP 400
    Given path '/booking/' + bookingId
    And request putRequestPartialValues
    When method PUT
    Then status 400
    And match response != "#object"

  Scenario:Verificar que al intentar actualizar un regiostro por medio de metodo PUT, con data extra, nos retorne un codigo de error HTTP 400
    Given path '/booking/' + bookingId
    And request putRequestExtraValues
    When method PUT
    Then status 400
    And match response != "#object"

