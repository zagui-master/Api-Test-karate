Feature:Como usuario de la plataforma de reservas Booking, quiero verificar que al eliminar un registro mediante el metodo DELETE,
el sistema procese correctamente las eliminaciones con IDs válidos y responda con los códigos de error adecuados
cuando los IDs sean incorrectos o inválidos

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


  Scenario: Verificar que al eliminar un registro mediante el metodo DELETE utilizando un ID correcto, el sistema realiza la eliminación de manera exitosa
    * def createNewBooking = call createBooking
    * def bookingId = createNewBooking.response.bookingid

    Given path 'booking/' + bookingId
    When method DELETE
    Then status 201
    Given path 'booking/' + bookingId
    When method GET
    Then status 404


  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> al intentar eliminar una reserva con un ID de <descriptionTitle>
    Given path 'booking/' + <invalidId>
    When method DELETE
    Then status <expectedStatus>
    Examples:
      | descriptionTitle      | invalidId | expectedStatus |
      | caracteres especiales | '%&/&(//' | 404            |
      | numeros negativos     | '-1562'   | 405            |


