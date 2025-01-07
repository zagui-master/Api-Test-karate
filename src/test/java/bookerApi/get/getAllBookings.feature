Feature:Verificar que la API de reservas de Booking devuelve todas las reservas correctamente al pasar parámetros válidos
y genera códigos de error adecuados cuando se pasan parámetros inválidos

  Background:
    * url baseUrl

  Scenario:Verificar que una consulta GET al path 'booking' devuelve un código HTTP 200
    Given path 'booking'
    When method GET
    Then status 200

  Scenario:Verificar que una consulta GET al path 'booking' devuelve una respuesta en formato array
    Given path 'booking'
    When method GET
    Then status 200
    And match response == "#[]"

  Scenario:Verificar que al realizar una consulta GET al path 'booking', el valor 'bookingid' es un número
    Given path 'booking'
    When method GET
    Then status 200
    And match response contains {"bookingid":"#number"}

  Scenario:Verificar que una consulta GET al path incorrecto ('bookingsdf') devuelve un código de error HTTP 404
    Given path 'bookingsdf'
    When method GET
    Then status 404



