Feature:Como usuario de la plataforma de reservas Booking, quiero verificar que al eliminar un registro mediante el metodo DELETE,
el sistema procese correctamente las eliminaciones con IDs válidos y responda con los códigos de error adecuados
cuando los IDs sean incorrectos o inválidos

  Background:
    * call read('classpath:bookerApi/auth/getToken.feature')
    * call read('classpath:bookerApi/common/createNewBooking.feature')
    * header Content-Type = "application/json"
    * header Accept = "application/json"
    * header Authorization = "Basic " + defaultToken
    * url baseUrl


  Scenario: Verificar que al eliminar un registro mediante el metodo DELETE utilizando un ID correcto, el sistema realiza la eliminación de manera exitosa
    Given path 'booking/' + bookingId
    When method DELETE
    Then status 201
    Given path 'booking/' + bookingId
    When method GET
    Then status 404

  Scenario:Verificar que al intentar eliminar un registro mediante el metodo DELETE utilizando un path incorrecto, el sistema retorna un código HTTP 404
    Given path 'bookingefgt/' + bookingId
    When method DELETE
    Then status 404

  Scenario Outline:Verificar que al intentar eliminar un registro mediante el metodo DELETE utilizando un ID con caracteres especiales, el sistema retorna un código HTTP 404
    Given path 'booking/' + incorrectId
    When method DELETE
    Then status 404
    Examples:
      | incorrectId |
      | %&/&(//(    |


  Scenario Outline:Verificar que al intentar eliminar un registro mediante el metodo DELETE utilizando un ID negativo, el sistema retorna un código HTTP 405
    Given path 'booking/' + incorrectId
    When method DELETE
    Then status 405
    Examples:
      | incorrectId |
      | -155        |
