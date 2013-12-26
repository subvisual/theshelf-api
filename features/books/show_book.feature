Feature: View book
  As a user
  I want to be able to see a book's details
  In order to borrow it

  Scenario: I can see the book's details
    Given I have an account on the system
    And there are books
    When I go to a book's page
    Then I should see the book's details
