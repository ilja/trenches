Feature: Manage projects
  In order have projects
  As a registered user
  I want to create, update and delete projects

  Background:
    Given I am logged in

  @omniauth_test
  Scenario: Create a project
    Given I am on the projects page
    When I follow "New Project"
    And I fill in "Name" with "My project"
    And I press "Create Project"
    Then I should see "'My project' was successfully created."
    And I should be on the projects page

  @omniauth_test
  Scenario: Update a project
    Given I am on the projects page
    And I have created project "asdf"
    When I follow "Edit"
    And I fill in "Name" with "My Special Test"
    And I press "Update Project"
    Then I should see "'My Special Test' was successfully updated."
    And I should be on the projects page
    And I should not see "asdf"

  @omniauth_test
  Scenario: Delete a project
    Given I am on the projects page
    And I have created project "deleteme"
    When I follow "Destroy"
    Then I should see "'deleteme' was successfully deleted."
    And I should be on the projects page
    And I should have no projects

   