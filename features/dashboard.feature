Feature: Dashboard
    In order to get an overview
    As a user or admin
    I want to have a dashboard view

    Background:
      Given... (common init for all scenarios)

    @tag
    Scenario: Dashboard page
      Given I have a browser
      When I go to the dashboard page
      Then I should see "Dashboard"

    Scenario: Dashboard content
      When I go to the dashboard page
      Then I should see many thumbnails
    