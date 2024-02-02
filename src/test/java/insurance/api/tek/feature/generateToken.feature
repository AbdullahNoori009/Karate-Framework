@Regression
Feature: Generate Access Token for TEk Insurance Application

#url we pass base url
  #path we pass the endpoint of a service
  #request we pass jason body POST and PUT methods
  #method we pass HTTP/HTTPS method type (GET,POST,PUT,DELETE)
  #status validates the response status code
  #print used for printing the response or variable into console
  #response this keyword prints API response.
  Background:
    Given url 'https://qa.insurance-api.tekschool-students.com'
  @GenerateToken
  Scenario: Generate Token
    * path '/api/token'
    * request {"username":"supervisor","password":"tek_supervisor"}
    * method post
    * status 200
    * print response
    * def tokenValue = response.token
    * print tokenValue

    Scenario: Verify Token
      * path '/api/token/verify'
      * def tokenGenerator = call read('generateToken.feature@GenerateToken')
      * def userValue = tokenGenerator.response.username
      * def getTokenValue = tokenGenerator.response.token
      * param username = userValue
      * param token = getTokenValue
      * method get
      * status 200
      * print response


