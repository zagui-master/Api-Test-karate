@regretion
Feature:Como usuario de la plataforma de reservas Booking, quiero validar que la API responda correctamente al realizar
una solicitud para obtener un recurso específico, para asegurarme de que la respuesta sea precisa, contenga los datos esperados
y que la consulta haya sido procesada exitosamente

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def createBooking =
      """
      function() {
        return karate.call('classpath:bookerApi/common/createNewBooking.feature');
      }
      """
  @happyPath
  Scenario:Verificar que al realizar una consulta con un ID válido, los datos devueltos coinciden con los valores esperados para ese ID
    * def createNewBooking = call createBooking
    * def bookingId = createNewBooking.response.bookingid
    * def expectedResponse = createNewBooking.requestData
    Given path "booking/" + bookingId
    When method GET
    Then status 200
    And match response == "#object"
    And match response ==  expectedResponse

  @unhappyPath
  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> <typeOfStatus>, al intentar concultar una reserva con un ID de <descriptionTitle>
    Given path "booking" + <invalidId>
    When method GET
    Then status <expectedStatus>
    And match response != '#object'
    Examples:
      | descriptionTitle      | invalidId | expectedStatus | typeOfStatus  |
      | caracteres especiales | "%$&?¡"   | 400            | "Bad Request" |
      | numeros negativos     | -1562     | 400            | "Bad Request" |

