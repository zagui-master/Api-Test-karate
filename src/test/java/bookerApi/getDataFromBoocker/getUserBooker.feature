Feature:
Como usuario de la plataforma de reservas Booking
Quiero validar que la API responda correctamente al realizar una solicitud para obtener un recurso específico
Para que pueda asegurarme de que la respuesta es precisa, contiene los datos esperados y que la consulta fue procesada exitosamente.

  Background:
    * def customer = read('../json/responseGetBooking.json')
    * header Accept = 'application/json'
    * url baseUrl
    Given path '/booking/1'
    When method GET


  Scenario:Verificar que al realizar una consulta con un ID válido, la respuesta tiene un código de estado HTTP 200
    Then status 200
    * print response

  Scenario:Verificar que al realizar una consulta con un ID válido, los datos devueltos están en el formato correcto
    Then match $ == customer.customerTypeOfData

  Scenario:Verificar que al realizar una consulta con un ID válido, los datos devueltos coinciden con los valores esperados para ese ID
    Then match $ == customer.customerData

  Scenario:Verificar que al realizar una consulta con un ID inválido, la respuesta tenga un código de estado HTTP 404
    Given path '/booking/-15'
    When method GET
    Then status 404