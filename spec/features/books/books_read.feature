Feature: See the books already read
  As a user
  I want to see the books I've already read

  Background:
    Given I have an account on the system

  Scenario: See read books
    Given I've read a book
    When I go to the edit account page
    Then I should see the read books list
