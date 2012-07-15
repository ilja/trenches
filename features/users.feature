Feature: Authentication
  In order to be known in the system
  As a user
  I want to authenticate with the system

  Scenario: Register as a new user
    Given I am on the home page
    When I choose to sign up for an account
    Then my account should be created

  Scenario: Log in as an existing user
    Given I have registered an account
    And I am on the home page
    When I sign in
    Then I should be signed in

  Scenario: Log in as an unregistered user
    Given I am on the home page
    When I sign in
    Then I should see a message that I am not registered

  Scenario: Log out
    Given I am logged in
    When I sign out
    Then I should be signed out



