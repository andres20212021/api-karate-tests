@ignore
Feature: Registro de Usuario

  Background:
    * url baseUrl
    * def userCredentials = read('classpath:data/auth_user.json')

  @registration_success
  Scenario: Registrar un nuevo usuario exitosamente
    Given path '/api/register'
    And request userCredentials
    When method post
    Then status 200
    And match response contains { id: '#number', token: '#string' }
    # Guardamos el ID para uso futuro
    * def generatedId = response.id
    * assert generatedId > 0
    * karate.log('Registro exitoso en archivo independiente. ID:', generatedId)