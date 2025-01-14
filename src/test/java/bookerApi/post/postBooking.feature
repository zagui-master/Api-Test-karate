@regretion
Feature: "Como usuario, quiero verificar el comportamiento de la API al crear nuevos registros,
utilizando tanto datos válidos como inválidos, para asegurarme de que el sistema maneje correctamente ambos casos


  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * def getRandomData =
      """
      function() {
        return karate.call('classpath:bookerApi/helpers/dataGeneratorTemplate.feature');
      }
      """


  @happyPath
  Scenario:Verificar que se puede crear un nuevo registro exitosamente con datos válidos
    * def createRequestData = call getRandomData
    * def requestData = createRequestData.requestDataTemplate
    * def expectedResponse = createRequestData.responseDataTemplate

    Given path '/booking'
    And request requestData
    When method POST
    Then status 200
    And match response == "#object"
    And match response == expectedResponse


  @unhappyPath
  Scenario Outline:Verificar que se obtiene un código de error HTTP <expectedStatus> <typeOfStatus>, al intentar crear un registro con <descriptionTitle>
    * def createRequestData = call getRandomData
    * def requestData = createRequestData

    Given path '/booking'
    And request requestData.<requestDataType>
    When method POST
    Then status <expectedStatus>
    And match response != "#object"
    Examples:
      | descriptionTitle     | requestDataType            | expectedStatus | typeOfStatus  |
      | parametros parciales | requestPartialDataTemplate | 400            | "Bad Request" |
      | parametros vacios    | requestEmptyDataTemplate   | 400            | "Bad Request" |
      | parametros null      | requestNullTDataTemplate   | 400            | "Bad Request" |
      | parametros extra     | dataRequestExtraValues     | 400            | "Bad Request" |


