@ignore
Feature: Generación de datos falsos para pruebas de API

  Background:
    * def fakerModule = Java.type('com.github.javafaker.Faker')
    * def faker = new fakerModule()
    * def firstname = faker.name().firstName()
    * def lastname = faker.name().lastName()
    * def fullName = faker.name().fullName()
    * def totalprice = faker.number().numberBetween(1, 1000)
    * def depositpaid = Math.random() > 0.5
    * def dateFormat = Java.type('java.text.SimpleDateFormat')
    * def checkinDate = new dateFormat('yyyy-MM-dd').format(faker.date().future(10, java.util.concurrent.TimeUnit.DAYS))
    * def checkoutDate = new dateFormat('yyyy-MM-dd').format(faker.date().future(20, java.util.concurrent.TimeUnit.DAYS))
    * def additionalneeds = faker.lorem().sentence()

  Scenario: Generate random data
    * def data =
      """
      {
        "firstname": "#(firstname)",
        "lastname": "#(lastname)",
        "totalprice": "#(totalprice)",
        "depositpaid": "#(depositpaid)",
        "checkin": "#(checkinDate)",
        "checkout": "#(checkoutDate)",
        "additionalneeds": "#(additionalneeds)",
        "nullData":null,
        "emptydata": "",
        "typeOfValue":{
          "number": "#number",
          "string": "#string",
          "boolenan":"#boolean"
        }
      }
      """



