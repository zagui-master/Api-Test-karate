@ignore
Feature:Template generador de data

  Background:
    * def fakerModule = call read('classpath:bookerApi/helpers/fakerDataGenerator.feature')
    * def bookingData = fakerModule.data

    * def requestTemplate =
      """
      function(data){
        return {
          "firstname": data.firstname,
          "lastname": data.lastname,
          "totalprice": data.totalprice,
          "depositpaid": data.depositpaid,
          "bookingdates": {
            "checkin": data.checkin,
            "checkout": data.checkout
          },
          additionalneeds: data.additionalneeds
        }
      }
      """

    * def responseTemplate =
      """
      function(data, requestData){
        return {
          bookingid: data.typeOfValue.number,
          booking: requestTemplate(data)
        }
      }
      """

    * def requestPartialTemplate =
      """
      function(data){
        return {
          "firstname": data.firstname,
          "lastname": data.lastname,
          "totalprice": data.totalprice,
          "depositpaid": data.depositpaid,
        }
      }
      """

    * def requestNullTemplate =
      """
      function(data){
        return {
          "firstname": data.nullData,
          "lastname": data.nullData,
          "totalprice": data.totalprice,
          "depositpaid": data.depositpaid,
          "bookingdates": {
            "checkin": data.nullData,
            "checkout": data.checkout
          },
          additionalneeds: data.nullData
        }
      }
      """

    * def requestExtraValuesTemplate =
      """
      function(data){
        return {
          "firstname": data.firstname,
          "lastname": data.lastname,
          "totalprice": data.totalprice,
          "depositpaid": data.depositpaid,
          "bookingdates": {
            "checkin": data.checkin,
            "checkout": data.checkout
          },
          additionalneeds: data.additionalneeds
        }
      }
      """

    * def requestDataTemplate = requestTemplate(bookingData)
    * def responseDataTemplate = responseTemplate(bookingData)
    * def requestPartialDataTemplate = requestPartialTemplate(bookingData)
    * def requestEmptyDataTemplate = {}
    * def requestNullTDataTemplate = requestNullTemplate(bookingData)
    * def dataRequestExtraValues = requestExtraValuesTemplate(bookingData)


  Scenario: Verificar que tanto la response como la reques contienen el atributo depositpaid como boolean
    * match requestTemplate(bookingData).depositpaid == "#boolean"
    * match requestPartialTemplate(bookingData).depositpaid == "#boolean"
    * match responseTemplate(bookingData).booking.depositpaid == "#boolean"
    * match requestNullTemplate(bookingData).depositpaid == "#boolean"
    * match requestExtraValuesTemplate(bookingData).depositpaid == "#boolean"




