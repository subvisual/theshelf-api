Feature: Sign up
  As a visitor
  I want to sign up
  In order to become a user and access the shelf

  Scenario: I can sign up
    Given I am a visitor
    And I am on the sign up page
    When I fill in the sign up form
    And I sign up
    Then I should be redirected to the shelf page
