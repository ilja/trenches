Feature: Manage stories
  In order to capture what a user should be able to do
  As a registered user
  I want to create, update and delete user stories
  
  Background:
    Given I am logged in
  
  @omniauth_test
  Scenario: Create a userstory
    Given I visit the backlog page of project "y"
    When I follow "New Story"
    And I fill in "Name" with "My first story"
    And I press "Create Story"
    Then I should see "'My first story' was successfully created."
    And I should return to the backlog page of project "y"

  @omniauth_test
  Scenario: Edit a userstory
    Given story "teststory" exists in the backlog of project "p"
    And I visit the backlog page of project "p"
    When I follow "Edit"
    And I fill in "Name" with "Better name"
    And I press "Update Story"
    Then I should see "'Better name' was successfully updated."
    And I should not see "teststory"

  @omniauth_test
  Scenario: Delete a userstory
    Given story "deleteme" exists in the backlog of project "d"
    And I visit the backlog page of project "d"
    When I follow "Destroy"
    Then I should see "'deleteme' was successfully deleted."
    And I should not see "deleteme" within "#storylist"
