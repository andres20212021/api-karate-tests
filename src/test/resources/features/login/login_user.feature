Feature: Inicio de Sesión de Usuario

  Background:
    * url baseUrl
    * def userCredentials = read('classpath:data/auth_user.json')

  @login_success
  @regression
  Scenario: Iniciar sesión con credenciales válidas y token valido
    Given path '/api/login'
    And request userCredentials
    When method post
    Then status 200
    And match responseHeaders['Content-Type'][0] contains 'application/json'
    # Validaciones de Token
    And match response.token == '#string'
    * def sessionToken = response.token
    * assert sessionToken.length >= 16
    * def result = { token: sessionToken }
    * karate.log('Login exitoso. Token obtenido:', sessionToken)









