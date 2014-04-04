Feature: Add a new book
  As a user
  I want to add a new book
  In order to have a wider book collection

  Scenario: I can add a book
    Given I have an account on the system
    And I am on the add a book page
    When I fill the new book form
    And I submit the book
    Then I should see the book's details

  Scenario: I can add a book that is not owned by the company
    Given I have an account on the system
    And I am on the add a book page
    When I fill the new book form
    And add myself as the book's owner
    And I submit the book
    Then I should see the book's details
    And that I am the book's owner

