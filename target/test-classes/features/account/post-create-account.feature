Feature: POST create account API

  Background:
    * url baseUrl
    * def accountData = call read('classpath:utils/account-data.js')
    * def accountActionsFeature = 'classpath:features/common/account-actions.feature'

  Scenario: Create account with valid payload
    * def createPayload = accountData.buildCreatePayload()
    Given path 'api', 'createAccount'
    And form fields createPayload
    When method post
    Then status 200
    And match response == { responseCode: '#number', message: '#string' }
    And match response.responseCode == 201
    And match response.message contains 'created'

    # Cleanup to keep tests idempotent.
    * def credentials = { email: '#(createPayload.email)', password: '#(createPayload.password)' }
    * call read(accountActionsFeature + '@deleteAccount') { credentials: '#(credentials)' }
