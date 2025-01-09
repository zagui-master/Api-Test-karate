@regretion
Feature:Como usuario, quiero actualizar un registro de reserva mediante el metodo PATCH, utilizando datos válidos e inválidos
para asegurarme de que el sistema maneja correctamente ambos casos


  Background:
    * def getToken = call read('classpath:bookerApi/auth/getToken.feature')
    * header Content-Type = "application/json"
    * header Accept = "application/json"
    * header Authorization = "Basic " + getToken.defaultToken
    * url baseUrl
    * def createBooking =
      """
      function() {
        return karate.call('classpath:bookerApi/common/createNewBooking.feature');
      }
      """
    * def getTestData =
      """
      function() {
        return karate.call('classpath:bookerApi/helpers/dataGeneratorTemplate.feature');
      }
      """

  @happyPath
  Scenario:Verificar que se puede actualizar una reserva exitosamente por ID
    * def createNewBooking = call createBooking
    * def createRequestData = call getTestData
    * def bookingId = createNewBooking.response.bookingid
    * def requestData = createRequestData.requestPartialDataTemplate
    * def expectedResponse = requestData

    Given path 'booking/' + bookingId
    And request requestData
    When method PATCH
    Then status 200
    And match response == "#object"
    And match response.firstname == expectedResponse.firstname
    And match response.lastname == expectedResponse.lastname


  @unhappyPath
  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> <typeOfStatus>, al intentar actualizar una reserva con ID de <descriptionTitle>
    * def createRequestData = call getTestData
    * def requestData = createRequestData.requestPartialDataTemplate

    Given path "booking/" + <invalidId>
    And request requestData
    When method PATCH
    Then status <expectedStatus>
    And match response != "#object"
    Examples:
      | descriptionTitle      | invalidId | expectedStatus | typeOfStatus  |
      | caracteres especiales | "%$&?¡"   | 400            | "Bad Request" |
      | numeros negativos     | -1562     | 400            | "Bad Request" |


  @unhappyPath
  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> <typeOfStatus>, al intentar actualizar una reserva con <descriptionTitle>
    * def createNewBooking = call createBooking
    * def createRequestData = call getTestData
    * def bookingId = createNewBooking.response.bookingid
    * def requestData = createRequestData

    Given path '/booking/' + bookingId
    And request requestData.<requestDataType>
    When method PATCH
    Then status <expectedStatus>
    And match response != "#object"
    Examples:
      | descriptionTitle     | requestDataType            | expectedStatus | typeOfStatus  |
      | parametros parciales | requestPartialDataTemplate | 400            | "Bad Request" |
      | parametros vacios    | requestEmptyDataTemplate   | 400            | "Bad Request" |
      | parametros null      | requestNullTDataTemplate   | 400            | "Bad Request" |
      | parametros extra     | dataRequestExtraValues     | 400            | "Bad Request" |
