Feature: Listing books
  As a user
  I want to be able to list all books
  In order to see existing books

  Scenario: I want to see all books
    Given I am a user
    And there are books
    When I go to the book's index
    Then I should see a list of all books

  Scenario: I want to see that there are no books available
    Given I am a user
    And there are no books
    When I go to the book's index
    Then I should see that there are no books
