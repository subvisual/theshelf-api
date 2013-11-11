Feature: Edit book
  As a user
  I want to edit a book
  In order to correct its details

  Scenario: I can edit a book
    Given I am a user
    And there is a book
    When I go to the book's edit page
    And I change the book's title
    And I submit the book
    Then I should see that the title has changed
