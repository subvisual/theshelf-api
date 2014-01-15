Feature: Borrow book
  As a user
  I want to borrow a book from the shelf
  In order to take it home and enjoy a nice read

  Background:
    Given I have an account on the system
    And there are available books

  @javascript @selenium
  Scenario: I borrow a book from the shelf page
    Given I am on the shelf page
    When I borrow an available book
    Then I see that the book was borrowed by me

  Scenario: I borrow a book from its page
    Given I am on a book's page
    When I borrow the book
    Then I see that the book was borrowed by me
