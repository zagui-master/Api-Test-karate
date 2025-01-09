@ignore
Feature: Como usuario de la plataforma de reservas Booking, quiero crear una nueva reserva para utilizarla como insumo
en otras consultas REST y asegurarme de que los datos sean procesados correctamente

  Background:
    * url baseUrl
     * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * def getTestData =
      """
      function() {
        return karate.call('classpath:bookerApi/helpers/dataGeneratorTemplate.feature');
      }
      """

  Scenario:Verificar que al realizar una solicitud POST para crear una nueva reserva, el sistema procesa la creación exitosamente y devuelve los datos correctos
    * def createRequestData = call getTestData
    * def requestData = createRequestData.requestDataTemplate
    * def expectedResponse = createRequestData.responseDataTemplate

    Given path '/booking'
    And request requestData
    When method POST
    Then status 200
    And match response == "#object"
    And match response == expectedResponse




