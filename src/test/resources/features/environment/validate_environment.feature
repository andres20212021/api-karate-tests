Feature: Validacion de API entre ambientes

  Background:
    * url baseUrl

  @regression
  Scenario: Verificar conexion basica y variables de entorno
    Given path '/api/users/2'
    When method get
    Then status 200
    And match response.data.id == 2
    * karate.log('>>> REPORTE DE QA <<<')
    * karate.log('Environment:', env)
    * karate.log('Usuario de prueba usado:', testUser)
    * karate.log('URL Base:', baseUrl)