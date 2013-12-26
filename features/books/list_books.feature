Feature: Listing books
  As a user
  I want to be able to list all books
  In order to see existing books

  Scenario: See all books
    Given I have an account on the system
    And there are books
    When I go to the shelf page
    Then I should see a list of all books

  Scenario: See that there are no books available
    Given I have an account on the system
    And there are no books
    When I go to the shelf page
    Then I should see that there are no books

  Scenario: See all books while not registered
    Given I am a visitor
    When I go to the shelf page
    Then I should be redirected to the sign in page
