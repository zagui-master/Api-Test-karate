@ignore
Feature: Generación de datos falsos para pruebas de API

  Background:
    * def faker = Java.type('com.github.javafaker.Faker')
    * def fakerInstance = new faker()
    * def firstname = fakerInstance.name().firstName()
    * def lastname = fakerInstance.name().lastName()
    * def fullName = firstname + ' ' + lastname
    * def totalprice = fakerInstance.number().numberBetween(1, 1000)
    * def depositpaid = Math.random() > 0.5
    * def sdf = Java.type('java.text.SimpleDateFormat')
    * def checkinDate = new sdf('yyyy-MM-dd').format(fakerInstance.date().future(10, java.util.concurrent.TimeUnit.DAYS))
    * def checkoutDate = new sdf('yyyy-MM-dd').format(fakerInstance.date().future(20, java.util.concurrent.TimeUnit.DAYS))
    * def additionalneeds = fakerInstance.lorem().sentence()

  Scenario: Crear data para metodo POST
    * def dataRequest =
      """
      {
        "firstname": "#(firstname)",
        "lastname": "#(lastname)",
        "totalprice": "#(totalprice)",
        "depositpaid": "#(depositpaid)",
        "bookingdates": {
          "checkin": "#(checkinDate)",
          "checkout": "#(checkoutDate)"
        },
        "additionalneeds": "#(additionalneeds)"
      }
      """

    * def dataResponse =
      """
      {
        "bookingid":"#number",
        "booking":{
          "firstname": "#(firstname)",
          "lastname": "#(lastname)",
          "totalprice": "#(totalprice)",
          "depositpaid": "#(depositpaid)",
          "bookingdates": {
            "checkin": "#(checkinDate)",
            "checkout": "#(checkoutDate)"
          },
          "additionalneeds": "#(additionalneeds)"
        }
      }
      """

    * def dataRequestNullValue =
      """
      {
        "firstname": null,
        "lastname": null,
        "totalprice": null,
        "depositpaid": null,
        "bookingdates": {
          "checkin": "#(checkinDate)",
          "checkout": "#(checkoutDate)"
        },
        "additionalneeds": "#(additionalneeds)"
      }
      """
    * def dataRequestPartialValues =
      """
      {
        "firstname": "#(firstname)",
        "lastname": "#(lastname)"
      }
      """
    * def dataRequestExtraValues =
      """
      {
        "firstname": "#(firstname)",
        "lastname": "#(lastname)",
        "fullName": "#(fullName)",
        "totalprice": "#(totalprice)",
        "depositpaid": "#(depositpaid)",
        "bookingdates": {
          "checkin": "#(checkinDate)",
          "checkout": "#(checkoutDate)"
        },
        "additionalneeds": "#(additionalneeds)"
      }
      """

    * def dataRequestEmpty =
      """
      {
      }
      """


