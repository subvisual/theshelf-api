Feature: Borrow book
  As a user
  I want to borrow a book from the shelf
  In order to take it home and enjoy a nice read

  Scenario: I borrow a book
    Given I have an account on the system
    And there are available books
    And I am on the shelf page
    When I borrow an available book
    Then I see that the book was borrowed by me

