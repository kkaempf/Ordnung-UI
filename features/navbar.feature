Feature: Navbar
    In order to access functions
    As a user or admin
    I want to have a navigation bar

    Background:
      Given... (common init for all scenarios)

    @tag
    Scenario: Product name
      Given I have a browser
      When I go to the home page
      Then I should see "Ordnung"

    Scenario: Navbar
      Given I am on the home page
      Then I should see a navigation bar
      And I should see a "Browse" link
      And I should see a "Import" link