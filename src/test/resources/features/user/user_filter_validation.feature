Feature: Validación de filtrado de usuarios

  Background:
    * url baseUrl

  @business
  @regression
  @filter
  Scenario: Buscar usuario específico usando karate.filter (George)
    Given path '/api/users'
    When method get
    Then status 200
    And match responseHeaders['Content-Type'][0] contains 'application/json'
    # Validamos lista de usuarios
    And match response.data == '#array'
    And assert response.data.length > 0
    # Guardamos usuarios
    * def users = response.data
    # Filtramos usuario George
    * def george = karate.filter(users, function(x){return x.first_name == 'George'})[0]
    # Validaciones del usuario encontrado
    And match george.first_name == 'George'
    And match george.last_name == 'Bluth'
    And match george.email contains '@reqres.in'
    * karate.log('Usuario filtrado correctamente:', george)