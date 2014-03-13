Feature: Edit account
  As a user
  I want to edit my account details
  In order to have my data updated

  Scenario: I can edit my account
    Given I have an account on the system
    And I am on the edit account page
    When I change my first name
    And I submit the new details
    Then I should see my new name

