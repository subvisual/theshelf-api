@javascript @selenium
Feature: Rate a book
  As a user
  I want to rate a book
  In order to allow other readers to know how good the book is

  Scenario: I rate a book
    Given I have an account on the system
    And there are books
    When I go to a book's page
    And I rate the book with 5 stars
    And I reload the page
    Then I see that the book's average rating was updated

  Scenario: I clear my rating
    Given I have an account on the system
    And there are books rated by me
    When I go to a book's page
    And I clear my rating
    And I reload the page
    Then I see that the book's average rating was updated

  Scenario: I edit my rating
    Given I have an account on the system
    And there are books rated by me
    When I go to a book's page
    And I rate the book with 5 stars
    And I reload the page
    Then I see that the book's average rating was updated
