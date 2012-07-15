Feature: Manage sprints
  In order to have sprints
  As a logged in user
  I want to manage my sprints

  Background: Sign in
    Given I am logged in
    And I have created a project

  Scenario: View a sprint
    Given I have added a sprint
    When I visit the project's sprints page
    Then I should be able to go to that sprint's page

  Scenario: Add a sprint
    When I visit the project's sprints page
    Then I should be able to add a new sprint

  Scenario: Edit a sprint
    Given I have added a sprint
    When I visit the project's sprints page
    Then I should be able to edit that sprint

  Scenario: Delete a sprint
    Given I have added a sprint
    When I visit the project's sprints page
    Then I should be able to delete that sprint

  Scenario: View the quickinfo of a sprint

  Scenario: View sprint planning
    Given I have added a sprint
    Then I should be able to visit that sprint's planning page

  Scenario: View stories added to sprint
    Given I have added a sprint
    And I have added a story to that sprint
    Then I should be able to see that story on the sprint's page

  Scenario: View latest sprint on project dashboard
    Given I have a sprint with stories
    When I go to my project's page
    Then I should see the latest sprint statistics
