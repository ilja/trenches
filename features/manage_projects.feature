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

  Scenario: Edit an existing project
  Scenario: Delete an existing project
  Scenario: Invite users to my project
  Scenario: Remove users from my project

