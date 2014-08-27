Feature: Signup sucess 
  I want to create my account
  And when click the sign up button
  Be redirected to the main page

  Scenario: Sign up sucess
    Given I am a visitor
    And I am on the sign up page
    And I put my information on the form
    When I click the sign up button
    Then I should be redirected to the shelf page