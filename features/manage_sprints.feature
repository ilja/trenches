Feature: Manage sprints
  In order develop iteratively
  As a developer
  I want to have sprints

  Scenario: Create a new sprint
    Given project "x" exists
    And I visit the sprints page for project "x"
    When I follow "New Sprint"
    And I fill in "Name" with "My first sprint"
    And I press "Create Sprint"
    Then I should see "'My first sprint' was successfully created."
    And I should be on the sprints page

  Scenario: Edit an existing sprint
    Given project "x" exists
    And I visit the sprints page for project "x"
    And I have created sprint "a sprint"
    When I follow "Edit"
    And I fill in "Name" with "The sprint"
    And I press "Update Sprint"
    Then I should see "'The sprint' was successfully updated."
    And I should be on the sprints page
    And I should not see "a sprint"

  Scenario: Delete an existing sprint
    Given project "x" exists
    And I visit the sprints page for project "x"
    And I have created sprint "deletesprint"
    When I follow "Destroy"
    Then I should see "'deletesprint' was successfully deleted."
    And I should be on the sprints page
    And I should not see "Destroy"
