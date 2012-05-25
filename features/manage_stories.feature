Feature: Manage stories
  In order to work on stories
  As a logged in user
  I want to manage my stories

  Background: Sign in
    Given I am logged in
    And I have created a project
    And I have added a sprint
    And I have added a story to that sprint

  Scenario: Start a story
    Given I am on the sprint's page
    Then I should be able to start the story

  Scenario: Finish a story
    Given I am on the sprint's page
    And I have started a story
    Then I should be able to finish it

  #TODO: wat met finishen van stories van anderen?
