@Regression
Feature: TEK Insurance POST Account API

  Background:
    Given  url appUrl
    * def tokenGenerator = call read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue


    Scenario: post and Account - Primary Person
      * def generator = Java.type('insurance.api.tek.utility.DataGenerator')
      * def email = generator.getEmail()
      * def firstName = generator.getFirstName()
      * def lastName = generator.getLastName()
      * def title = generator.getTitle()
      * def gender = generator.getGender()
      * def employmentStatus = generator.getEmploymentStatus()
      * def MaritalStatus = generator.getMaritalStatus()
      * def DateOfBirth = generator.getDateOfBirth()
      * path '/api/accounts/add-primary-account'
      * request
      """
{
  "id": 0,
  "email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "#(title)",
  "gender": "#(gender)",
  "maritalStatus": "#(MaritalStatus)",
  "employmentStatus": "#(employmentStatus)",
  "dateOfBirth": "#(DateOfBirth)",
  "new": true
}
      """
      * method post
      * status 201
      * print response
      * karate.write(response, 'createdAccount.json')
      * match response.firstName == firstName
      * match response.lastName == lastName
      * match response.email == email
  @postPhone
  Scenario:  Post Phone - Primary Person
    * def generator = Java.type('insurance.api.tek.utility.DataGenerator')
    * def PhoneNumber = generator.getPhoneNumber()
    * def PhoneExtension = generator.getPhoneExtension()
    * def PhoneType = generator.getPhoneType()
    * def PhoneTime = generator.getPhoneTime()
    * path '/api/accounts/add-account-phone'
    * def primarypersonIdValue = read('file:./target/createdAccount.json')
    * param primaryPersonId = primarypersonIdValue.id
    * request
    """
    {
  "phoneNumber": "#(PhoneNumber)",
  "phoneExtension": "#(PhoneExtension)",
  "phoneTime": "#(PhoneType)",
  "phoneType": "#(PhoneTime)"
    }
    """
    * method post
    * status 201
    * print response
    * match response.phoneNumber == PhoneNumber
    * def phoneId = response.id
    * print phoneId

    Scenario: Post Add - Account - Car
      * def generator = Java.type('insurance.api.tek.utility.DataGenerator')
      * def make = generator.getMake
      * def model = generator.getModel
      * def year = generator.getYear
      * def licensePlate = generator.getLicensePlate
      * path '/api/accounts/add-account-car'
      * def primarypersonIdValue = read('file:./target/createdAccount.json')
      * param primaryPersonId = primarypersonIdValue.id
      * request
      """
      {
  "make": "Mazda",
  "model": "CX5",
  "year": "2024",
  "licensePlate": "Broot1"
}
      """
      * method post
      * status 201
      * print response




