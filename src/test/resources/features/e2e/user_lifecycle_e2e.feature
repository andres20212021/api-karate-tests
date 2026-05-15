Feature: Flujo E2E mínimo de usuario

  Background:
    * url baseUrl
    # Reutilizamos registro
    * def registro = callonce read('classpath:features/registerUser/register_user.feature')
    # Obtenemos ID dinámico
    * def userId = registro.generatedId
    # Datos dinámicos para actualización
    * def timestamp = new Date().getTime()
    * def updatedName = 'Andres QA ' + timestamp
    * def updatedJob = 'QA Automation ' + timestamp
    # Payload externo
    * def updatePayload = read('classpath:data/update_user.json')

  @e2e
  @regression
  Scenario: Registro, consulta, actualización y eliminación de usuario
    # Validamos ID generado
    * match userId == '#number'
    * assert userId > 0
    # Consultar usuario
    Given path '/api/users/', userId
    When method get
    Then status 200
    And match response.data.id == userId
    And match response.data.email == '#string'
    # Actualizar usuario
    Given path '/api/users/', userId
    And request updatePayload
    When method put
    Then status 200
    And match response.name == updatedName
    And match response.job == updatedJob
    And match response.updatedAt == '#string'
    * karate.log('Flujo E2E name actualizado :', response.name)
    * karate.log('Flujo E2E trabajo actualizado :', response.job)
    # Eliminar usuario
    Given path '/api/users/', userId
    When method delete
    Then status 204
    * karate.log('Flujo E2E ejecutado correctamente para userId:', userId)