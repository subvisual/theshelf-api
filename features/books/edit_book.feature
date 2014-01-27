Feature: Edit book
  As a user
  I want to edit a book
  In order to correct its details

@javascript @selenium
  Scenario: I can edit a book
    Given I have an account on the system
    And there are books
    When I go to a book's edit page
    And I change the book's title
    And I submit the book
    Then I should see that the title has changed
