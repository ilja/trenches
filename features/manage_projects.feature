Feature: Manage projects
  In order to have projects
  As a logged in user
  I want to manage my projects

  Background: Sign in
    Given I am logged in

  Scenario: Create a new project
    Given I am on the home page
    When I go to my projects page
    And I create a new project
    Then I should see my new project

  Scenario: View an existing project
    Given I have created a project
    And I go to my projects page
    Then I should be able to view my project

  Scenario: Edit an existing project
    Given I have created a project
    And I go to my projects page
    Then I should be able to change my project

  Scenario: Delete an existing project
    Given I have created a project
    And I go to my projects page
    Then I should be able to delete my project

  Scenario: Add members to my project
    Given I have created a project
    And I go to my projects page
    Then I should be able to add members

  Scenario: Remove members from my project

