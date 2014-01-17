Feature: Return book
  As a user
  I want to return a borrowed book
  In order to let others borrow it

  Background:
    Given I have an account on the system

  Scenario: I return a borrowed book from the shelf page
    Given I've borrowed a book
    And I am on the shelf page
    When I return the book
    Then I see that the book is available for borrowing

  Scenario: I return a book from its page
    Given I've borrowed a book
    And I am on a borrowed book's page
    When I return the book
    Then I see that the book is available for borrowing

  Scenario: I can't return a book that wasn't borrowed by me
    Given there are no books borrowed by me
    When I go to the shelf page
    Then I can't see a return button

  Scenario: I review a book when I return it
    Given I've borrowed a book
    And I am on the shelf page
    And I return the book
    And I fill the review form
    And I submit the review
    Then I see that the book is available for borrowing
