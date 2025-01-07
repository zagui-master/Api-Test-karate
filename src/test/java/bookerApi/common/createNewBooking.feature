@ignore
Feature: Como usuario de la plataforma de reservas Booking, quiero crear una nueva reserva para utilizarla como insumo
en otras consultas REST y asegurarme de que los datos sean procesados correctamente

  Background:
    * def createDataRequest = read('classpath:bookerApi/common/createDataRequest.json')
    * def createDataResponse = read('classpath:bookerApi/common/createDataResponse.json')
    * url baseUrl
    * path '/booking'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario:Verificar que al realizar una solicitud POST para crear una nueva reserva, el sistema procesa la creación exitosamente y devuelve los datos correctos
    Given request createDataRequest
    When method POST
    Then status 200
    * def json_response = response
    And match json_response == "#object"
    And match json_response == createDataResponse
    * def bookingId = json_response.bookingid


