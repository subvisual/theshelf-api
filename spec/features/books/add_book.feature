Feature: Add a new book
  As a user
  I want to add a new book
  In order to have a wider book collection

  Scenario: I can add a book
    Given I have an account on the system
    And I am on the add a book page
    When I fill the book form
    And I submit the book
    Then I should see the book's details

  Scenario: I can add a book that is not owned by the company
    Given I have an account on the system
    And I am on the add a book page
    When I fill the book form
    And add myself as the book's owner
    And I submit the book
    Then I should see the book's details
    And that I am the book's owner

  Scenario: I can add a book by its ISBN
    Given I have an account on the system
    And I am on the add a book page
    When I fill the ISBN form
    And I submit the ISBN
    Then I should see the book's details

  Scenario: I can add an ebook
    Given I have an account on the system
    And I am on the add a book page
    When I fill the ebook form
    And I submit the book
    Then I should see the book's details
    And a button to download the ebook
