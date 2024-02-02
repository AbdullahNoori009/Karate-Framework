Feature: TEK Insurance PUT API
  Background:
    Given url appUrl
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue



  Scenario: Put API - Update Phone number Primary Person
    * path '/api/accounts/update-account-phone'
    * def primarypersonIdValue = read('file:./target/createdAccount.json')
    * param primaryPersonId = primarypersonIdValue.id
    * def phoneIdExtraction = call read('postAcccount.feature@postPhone')
    * def phoneIdValue = phoneIdExtraction.phoneId
    * print phoneIdValue
    * request
    """
    {
  "id": #(phoneIdValue),
  "phoneNumber": "4447893470",
  "phoneExtension": "001",
  "phoneTime": "Morning",
  "phoneType": "Cell Phone"
}
    """
    * method put
    * status 200
    * print response




