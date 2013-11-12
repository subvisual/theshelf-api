Feature: Add a new book
  As a registered user
  I want to add a new book
  In order to have a wider book collection

  Scenario: I can add a book
    Given I am a registered user
    And I am on the add a book page
    When I fill the new book form
    And I submit the book
    Then I should see the book's details
