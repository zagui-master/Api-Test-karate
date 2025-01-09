@ignore
Feature: Como usuario de la plataforma de reservas Booking, quiero crear una nueva reserva para utilizarla como insumo
en otras consultas REST y asegurarme de que los datos sean procesados correctamente

  Background:
    #* def createDataRequest = read('classpath:bookerApi/common/createDataRequest.json')
    #* def createDataResponse = read('classpath:bookerApi/common/createDataResponse.json')
    * call read('classpath:bookerApi/helpers/generateTestData.feature')
    * def postRequest = dataRequest
    * def postResponse = dataResponse
    * url baseUrl
    * path '/booking'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario:Verificar que al realizar una solicitud POST para crear una nueva reserva, el sistema procesa la creación exitosamente y devuelve los datos correctos
    Given request postRequest
    When method POST
    Then status 200
    And match response == "#object"
    And match response == postResponse
    * def dataResponse = postRequest
    * def bookingId = response.bookingid


