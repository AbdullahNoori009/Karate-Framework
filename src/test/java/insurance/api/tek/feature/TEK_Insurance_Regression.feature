Feature: TEK Insurance Regression Suite
  Background:
    Given url appUrl
    * def tokenGenerator = callonce read('generateToken.feature@GenerateToken')
    * def tokenValue = tokenGenerator.response.token
    * header Authorization = 'Bearer ' + tokenValue

    Scenario: Post an account - Primary Person
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
      * match response.email == email
      * print response
      * karate.write(response, 'RegressionCreateAccount.json')

      Scenario: Post a car - Primary Person Account
        * path '/api/accounts/add-account-car'
        * def primarypersonIdValue = read('file:./target/RegressionCreateAccount.json')
        * param primaryPersonId = primarypersonIdValue.id
        * request
        """
       {
  "make": "BMW",
  "model": "XMw",
  "year": "2023",
  "licensePlate": "Tiger003"
}
        """
        * method post
        * status 201
        * print response
        * match response.licensePlate == 'Tiger003'
        * karate.write(response, 'RegressionPostCar.json')

  Scenario: put (Update) a car - Primary Person Account
    * path '/api/accounts/update-account-car'
    * def extractCarId = read('file:./target/RegressionPostCar.json')
    * def carIdValue = extractCarId.id
    * def primarypersonIdValue = read('file:./target/RegressionCreateAccount.json')
    * param primaryPersonId = primarypersonIdValue.id
    * request
      """
      {
  "id": #(carIdValue),
  "make": "Audi",
  "model": "Q7",
  "year": "2024",
  "licensePlate": "response"
}
      """
    * method put
    * status 202
    * print response

  Scenario: Delete a car - Primary person
    * path '/api/accounts/delete-car'
    * def extractCarId = read('file:./target/RegressionPostCar.json')
    * def carIdValue = extractCarId.id
    * param carId = carIdValue
    * method delete
    * status 202
    * print response
    * match response.message contains 'had been deleted'








