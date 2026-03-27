 Feature: DELETE account API

  Background:
    * url baseUrl
    * def accountData = call read('classpath:utils/account-data.js')
    * def accountActionsFeature = 'classpath:features/common/account-actions.feature'

  Scenario: Delete existing account and validate response fields
    * def createPayload = accountData.buildCreatePayload()
    * def createArgs = { payload: '#(createPayload)' }
    * def created = call read(accountActionsFeature + '@createAccount') createArgs
    * def credentials = created.accountCredentials

    Given path 'api', 'deleteAccount'
    And form fields credentials
    When method delete
    Then status 200
    And match response == { responseCode: '#number', message: '#string' }
    And match response.responseCode == 200
    And match response.message contains 'deleted'
