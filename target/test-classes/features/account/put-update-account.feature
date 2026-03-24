Feature: PUT update account API

  Background:
    * url baseUrl
    * def accountData = call read('classpath:utils/account-data.js')
    * def accountActionsFeature = 'classpath:features/common/account-actions.feature'

  Scenario: Update existing account and validate response fields
    * def createPayload = accountData.buildCreatePayload()
    * def created = call read(accountActionsFeature + '@createAccount') { payload: '#(createPayload)' }
    * def credentials = created.accountCredentials
    * def updatePayload = accountData.buildUpdatePayload(credentials.email, credentials.password)

    Given path 'api', 'updateAccount'
    And form fields updatePayload
    When method put
    Then status 200
    And match response == { responseCode: '#number', message: '#string' }
    And match response.responseCode == 200
    And match response.message contains 'updated'

    * call read(accountActionsFeature + '@deleteAccount') { credentials: '#(credentials)' }
