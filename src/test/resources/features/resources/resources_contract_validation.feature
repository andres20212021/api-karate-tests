Feature: Validación de recursos

  Background:
    * url baseUrl
    * def resourceSchema = read('classpath:schemas/resource_item_schema.json')

  @contract
  @business
  @regression
  Scenario: Validar listado de recursos y reglas de negocio
    Given path '/api/unknown'
    When method get
    Then status 200
    And match responseHeaders['Content-Type'][0] contains 'application/json'
    # Validación básica del array
    And match response.data == '#array'
    And assert response.data.length > 0
    And assert response.data.length == response.per_page
    # Validación masiva usando schema externo
    And match each response.data == resourceSchema
    # Validaciones de paginación
    And match response.page == 1
    And match response.per_page == 6
    And assert response.total >= response.data.length
    And assert response.total_pages > 0
    # Validaciones de soporte
    And match response.support.url == '#regex ^https://.*'
    And assert response.support.text.length > 20
    # Validaciones de metadata
    And match response._meta.powered_by == 'ReqRes'
    And match response._meta.docs_url == '#regex ^https://.*'
    And match response._meta.cta.url == '#regex ^https://.*'
    And match response._meta.context contains 'success'
    # Performance básica
    And assert responseTime < 3000
    * karate.log('Listado de recursos validado correctamente. Total:', response.total)