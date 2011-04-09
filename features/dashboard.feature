Feature: Dashboard
    In order to get an overview
    As a user or admin
    I want to have a dashboard view

    Background:
      Given... (common init for all scenarios)

    @tag
    Scenario: Start page
      Given I have a browser
      When I go to the dashboard page
      Then I should see "Dashboard"

    Scenario: Add item
      Given I am on the dashboard page
      Then I should see "Add item"
      When I follow "Add item"
      Then I should see "File to Import"

    Scenario: Select directory
      Given I am on the dashboard page
      Then I should see "Add directory"
      When I follow "Add directory"
      Then I should be on the directory page
