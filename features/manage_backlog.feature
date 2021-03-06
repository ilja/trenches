Feature: Manage projects
  In order to have projects
  As a logged in user
  I want to manage my projects

  Background: Sign in
    Given I am logged in
    And I have created a project

  Scenario: Visit the project backlog
    When I go to my project's page
    And I go to its backlog page
    Then I should see the product backlog

  Scenario: Add a new story
    When I visit the project's backlog page
    Then I should be able to add a new story

  Scenario: Edit a story
    Given I have added a story
    When I visit the project's backlog page
    Then I should be able to edit that story

  Scenario: Delete a story
    Given I have added a story
    When I visit the project's backlog page
    Then I should be able to delete that story

  Scenario: Show all open stories
  Scenario: Show all active stories
  Scenario: Show all done stories

  Scenario: View the top 10 backlog items on the dashboard
    Given I have 11 backlog items
    When I go to my project's page    
    Then I should see the top 10 backlog items