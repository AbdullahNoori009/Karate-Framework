@Regression
Feature: TEK Insurance GET Account API

  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue


    Scenario: Get Primary Person Account
      * path '/api/accounts/get-primary-account'
      * param primaryPersonId = 2599
      * method get
      * status 200
      * print response
      * match response.firstName == 'John'
      * match response.lastName == 'Sakhi'
      * match response.id == 2599
      * match response.employmentStatus == 'student'
      * match response.email contains '@Tekschool.us'
      * match response.email == 'Johnsakhi@Tekschool.us'

      Scenario: Get All Accounts
        * path '/api/accounts/get-all-accounts'
        * method get
        * status 200
        * print response [0]
        #* match response[0].firstName == 'Mujib'


        Scenario: Get Accounts Details
          * path '/api/accounts/get-account'
          * param primaryPersonId = 2477
          * method get
          * status 200
          * print response
          * def idValue = response.primaryPerson.id
          * match idValue == 2477
          * match response.primaryPersonCars[0].licensePlate == 'ABCY75'
          * match response.user.accountType == 'CUSTOMER'
          * match response.user.authorities[0].role == 'CUSTOMER'





