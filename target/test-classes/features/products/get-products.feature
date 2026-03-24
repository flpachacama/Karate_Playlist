Feature: GET products API

  Background:
    * url baseUrl
    * def productsSchema = read('classpath:data/schemas/products-schema.json')

  Scenario: Get products list returns valid response and expected product structure
    Given path 'api', 'productsList'
    When method get
    Then status 200
    And match response == productsSchema
    And match response.responseCode == 200
    And match response.products[0] contains
      """
      {
        id: '#number',
        name: '#string',
        price: '#string',
        brand: '#string',
        category: {
          usertype: {
            usertype: '#string'
          },
          category: '#string'
        }
      }
      """
