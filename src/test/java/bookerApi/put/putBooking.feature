@regretion
Feature:Como usuario de la plataforma de reservas Booking, quiero verificar que al actualizar un registro mediante el metodo PUT,
el sistema procese correctamente los datos válidos y responda con los códigos de error adecuados cuando los datos sean incorrectos,
incompletos, nulos o extras

  Background:
    * def getToken = call read('classpath:bookerApi/auth/getToken.feature')
    * header Content-Type = "application/json"
    * header Accept = "application/json"
    * header Cookie = getToken.token
    * url baseUrl
    * def createBooking =
      """
      function() {
        return karate.call('classpath:bookerApi/common/createNewBooking.feature');
      }
      """
    * def getRandomData =
      """
      function() {
        return karate.call('classpath:bookerApi/helpers/dataGeneratorTemplate.feature');
      }
      """

  @happyPath
  Scenario:Verificar que se puede actualizar una reserva exitosamente por ID
    * def createNewBooking = call createBooking
    * def createRequestData = call getRandomData
    * def bookingId = createNewBooking.response.bookingid
    * def requestData = createRequestData.requestDataTemplate
    * def expectedResponse = requestData

    Given path 'booking/' + bookingId
    And request requestData
    When method PUT
    Then status 200
    And match response == "#object"
    And match response == expectedResponse


  @unhappyPath
  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> <typeOfStatus>, al intentar actualizar una reserva con ID de <descriptionTitle>
    * def createRequestData = call getRandomData
    * def requestData = createRequestData.dataRequest

    Given path 'booking/' + <invalidId>
    And request requestData
    When method PUT
    Then status <expectedStatus>
    And match response != "#object"
    Examples:
      | descriptionTitle      | invalidId | expectedStatus | typeOfStatus  |
      | caracteres especiales | "%$&?¡"   | 400            | "Bad Request" |
      | numeros negativos     | -1562     | 400            | "Bad Request" |


  @unhappyPath
  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> <typeOfStatus>, al intentar actualizar una reserva con <descriptionTitle>
    * def createNewBooking = call createBooking
    * def createRequestData = call getRandomData
    * def bookingId = createNewBooking.response.bookingid
    * def requestData = createRequestData

    Given path 'booking/' + bookingId
    And request requestData.<requestDataType>
    When method PUT
    Then status <expectedStatus>
    And match response != "#object"
    Examples:
      | descriptionTitle     | requestDataType            | expectedStatus | typeOfStatus  |
      | parametros parciales | requestPartialDataTemplate | 400            | "Bad Request" |
      | parametros vacios    | requestEmptyDataTemplate   | 400            | "Bad Request" |
      | parametros null      | requestNullTDataTemplate   | 400            | "Bad Request" |
      | parametros extra     | dataRequestExtraValues     | 400            | "Bad Request" |



