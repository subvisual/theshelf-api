@javascript
Feature: Search books
  As a user
  I want to be able to search for books
  In order to find the book I want to borrow

  Background:
    Given I have an account on the system
    And there are books
    And I am on the shelf page

  Scenario Outline: I can search a book
    When I search a book by its <parameter>
    Then I should see the book listed

    Examples:
      | parameter |
      | title     |
      | author    |

  Scenario: I search for a non existing book
    Given there isn't a book with title Leicionario
    When I search for that word
    Then I should see an empty search results message
