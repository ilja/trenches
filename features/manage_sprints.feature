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

