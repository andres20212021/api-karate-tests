@regression
Feature: Validación de Usuario - Contrato y Negocio

  Background:
    * url baseUrl
    * def registro = callonce read('classpath:features/registerUser/register_user.feature')
    * def userId = registro.generatedId
    * def userSchema = read('classpath:schemas/single_user_schema.json')

  @contract
  Scenario: Validación de Contrato (Estructura Técnica)
    Given path '/api/users/', userId
    When method get
    Then status 200
    And match response == userSchema
    And match response.data.id == userId
    * karate.log('Contrato validado para el ID:', userId)

  @business
  Scenario: Validación de Lógica de Negocio (Formatos y Reglas)
    Given path '/api/users/', userId
    When method get
    Then status 200
    And match responseHeaders['Content-Type'][0] contains 'application/json'
  # email tenga un formato válido
    And match response.data.email == "#regex ^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
  # avatar sea una URL de imagen válida
    And match response.data.avatar == "#regex ^https://.*\\.(jpg|jpeg|png|webp)$"
  # Validamos que el ID coincida y sea un número positivo
    And match response.data.id == userId
    And assert response.data.id > 0
    And match response.data.first_name == "#string"
    And assert response.data.first_name.length > 0
    And match response.data.last_name == "#string"
    And assert response.data.last_name.length > 0
  # enlaces dentro de _meta sean URLs HTTPS
    And match response._meta.docs_url == "#regex ^https://.*"
    And match response._meta.cta.url == "#regex ^https://.*"
  # debe tener una longitud mínima
    * def supportText = response.support.text
    And assert supportText.length > 20
    * karate.log('Validación completada para userId:', userId)