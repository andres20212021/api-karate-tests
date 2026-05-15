Feature: Pruebas negativas de autenticacion (Unhappy Paths)

  Background:
    * url baseUrl
    * def errorSchema = read('classpath:schemas/login_error_response_schema.json')

    @error_handling
    @regression
  Scenario Outline: Login fallido por: <descripcion>
    Given path '/api/login'
    And request { "email": "<email>", "password": "<password>" }
    When method post
    Then status 400
    And match responseHeaders['Content-Type'][0] contains 'application/json'
    # Validación de contrato de error
    And match response == errorSchema
    # Validación de mensaje esperado
    And match response.error == "<error_esperado>"
    # Performance basica
    And assert responseTime < 3000
    * karate.log('Prueba de <descripcion> exitosa. Error validado:', response.error)

    Examples:
      | descripcion       | email              | password   | error_esperado            |
      | Password vacio    | eve.holt@reqres.in |            | Missing password          |
      | Email vacio       |                    | cityslicka | Missing email or username |
      | Ambos vacios      |                    |            | Missing email or username |
      | Usuario no existe | error@reqres.in    | 123456     | user not found            |