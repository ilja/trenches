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


  Scenario: Backlog without stories

  Scenario: Add a new story
  	When I visit the project's backlog page
  	Then I should be able to add a new story

  Scenario: Edit a story
  Scenario: Delete a story
