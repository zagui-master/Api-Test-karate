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
          additionalneeds: data.additionalNeeds
        }
      }
      """

    * def responseTemplate =
      """
      function(data) {
        return {
          bookingid: '#number',
          booking:requestTemplate(data),
        };
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

    * def requestEmptyTemplate =
      """
      { }
      """

  Scenario: Verificar que tanbto como la response como la reques continen el atributo depositpaid como boolean
    * match requestTemplate(bookingData).depositpaid == "#boolean"
    * match responseTemplate(bookingData).booking.depositpaid == "#boolean"
    * match requestNullTemplate(bookingData).depositpaid == "#boolean"
    * match requestPartialTemplate(bookingData).depositpaid == "#boolean"
    * match requestEmptyTemplate == {}

    * def requestDataTemplate = requestTemplate(bookingData)
    * def responseDataTemplate = responseTemplate(bookingData)
    * def requestNullTDataTemplate = requestNullTemplate(bookingData)
    * def requestPartialDataTemplate = requestPartialTemplate(bookingData)
    * def requestEmptyDataTemplate = requestEmptyTemplate


