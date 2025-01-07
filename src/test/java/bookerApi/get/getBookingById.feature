Feature:Como usuario de la plataforma de reservas Booking, quiero validar que la API responda correctamente al realizar
una solicitud para obtener un recurso específico, para asegurarme de que la respuesta sea precisa, contenga los datos esperados
y que la consulta haya sido procesada exitosamente

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario:Verificar que al realizar una consulta con un ID válido, los datos devueltos coinciden con los valores esperados para ese ID
    * call read("classpath:bookerApi/common/createNewBooking.feature")
    * def expectedResponse = read("classpath:bookerApi/get/getDataResponse.json")
    Given path "booking/" + bookingId
    When method GET
    Then status 200
    * def json_response = $
    And match json_response == "#object"
    And match json_response == expectedResponse

  @ignore
  Scenario Outline:Verificar que al realizar una consulta con un ID inválido, la respuesta tenga un código de estado HTTP 404
    Given path "booking" + incorrectId
    When method GET
    Then status 404
    * def json_response = $
    And match json_response != '#object'
    Examples:
      | incorrectId |
      | %&/&(//(    |
      | -1562       |

