Feature: User manages watches
  In order to keep up with a listing in Sharetribe
  As a person who needs something or has something
  I want to be able to add or remove listings to a watch list

  @sphinx @no-transaction
  Scenario: User adds a listing to their watch list
    Given there are following users:
      | person |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is a listing with title "car spare parts" from "kassi_testperson1" with category "Items" and with listing shape "Selling"
    And I am logged in as "kassi_testperson2"
    When I follow "car spare parts"
    And I should see "Add to Watch List"
    When I follow "Add to Watch List"
    And I should see "You are now watching car spare parts."

  @javascript @sphinx @no-transaction
  Scenario: User adds a listing to their watch list with JavaScript
    Given there are following users:
      | person |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is a listing with title "car spare parts" from "kassi_testperson1" with category "Items" and with listing shape "Selling"
    And I am logged in as "kassi_testperson2"
    When I follow "car spare parts"
    And I should see "Add to Watch List"
    When I follow "Add to Watch List"
    And I should see "Remove from Watch List"

  @sphinx @no-transaction
  Scenario: User removes a listing to their watch list
    Given there are following users:
      | person |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is a listing with title "leftover parts" from "kassi_testperson1" with category "Items" and with listing shape "Selling"
    And I am logged in as "kassi_testperson2"
    And I am watching "leftover parts"
    When I follow "leftover parts"
    And I should see "Remove from Watch List"
    When I follow "Remove from Watch List"
    And I should see "You have stopped watching leftover parts."

  @javascript @sphinx @no-transaction
  Scenario: User removes a listing to their watch list with JavaScript
    Given there are following users:
      | person |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is a listing with title "leftover parts" from "kassi_testperson1" with category "Items" and with listing shape "Selling"
    And I am logged in as "kassi_testperson2"
    And I am watching "leftover parts"
    When I follow "leftover parts"
    And I should see "Remove from Watch List"
    When I follow "Remove from Watch List"
    And I should see "Add to Watch List"

  @javascript @sphinx @no-transaction
  Scenario: User that is not signed in should not see watch options
    Given there are following users:
      | person |
      | kassi_testperson1 |
    And there is a listing with title "gravy boat" from "kassi_testperson1" with category "Items" and with listing shape "Selling"
    And I am on the home page
    When I follow "gravy boat"
    And I should not see "Add to Watch List"
