Feature: Validación Asincrónica con Retry Until

  Background:
    * url baseUrl
    # count: máximo 5 intentos | interval: esperar 3000ms (3 seg) entre cada uno
    * configure retry = { count: 5, interval: 3000 }
    * def registro = callonce read('classpath:features/registerUser/register_user.feature')
    * def userId = registro.generatedId
  @async
  @regression
  Scenario: Esperar a que el usuario esté disponible en la DB
    Given path '/api/users/', userId
    # seguirá intentando MIENTRAS la condición sea falsa.
    And retry until responseStatus == 200 && response.data.first_name != null
    When method get
    #Solo se llega aquí si la condición de arriba se cumplió
    Then status 200
    And match response.data.id == userId
    And match response.data.first_name == "#notnull"
    * karate.log('Usuario encontrado después de los reintentos necesarios')