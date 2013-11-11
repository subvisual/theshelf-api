Feature: View book
  As a user
  I want to be able to see a book's details
  In order to borrow it

  Scenario: I can see the book's details
    Given I am a user
    And there is a book
    When I go to the book's page
    Then I should see the book's details
