Feature: Review a book
  As a user
  I want to review a book
  In order to allow other readers to know what I think about it

  Scenario: I review a book
    Given I have an account on the system
    And there are books
    When I go to a book's page
    And I fill the review form
    And I submit the review
    Then I should see my new review
