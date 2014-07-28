Feature: Extend loan
  As a user
  I want to extend my loan
  In order to have more time to read it

  Scenario: I extend my book loan
    Given I have an account on the system
    And I've borrowed a book
    And there is one week left on my loan
    And I am on the shelf page
    When I extend my loan period
    Then I should see that my loan was extended

  Scenario: I extend my book loan a second time
    Given I have an account on the system
    And I've borrowed a book
    And I've extended the loan
    And there is one week left on my loan
    When I go to the shelf page
    Then I should not see an extend link
