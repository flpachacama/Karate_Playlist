Feature: Common account actions for API tests

  Background:
    * url baseUrl

  @createAccount
  Scenario: Create account with valid data
    * match payload contains { name: '#string', email: '#string', password: '#string' }
    Given path 'api', 'createAccount'
    And form fields payload
    When method post
    Then status 200
    And match response == { responseCode: '#number', message: '#string' }
    And match response.responseCode == 201
    * def accountCredentials = { email: '#(payload.email)', password: '#(payload.password)' }

  @deleteAccount
  Scenario: Delete account with existing credentials
    * match credentials contains { email: '#string', password: '#string' }
    Given path 'api', 'deleteAccount'
    And form fields credentials
    When method delete
    Then status 200
    And match response == { responseCode: '#number', message: '#string' }
    And match response.responseCode == 200
