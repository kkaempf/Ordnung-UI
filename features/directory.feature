Feature: Directory
    In order to add many files
    As a user or admin
    I want to select directores for adding

    Background:
      Given... (common init for all scenarios)

    @tag
    Scenario: Browse directories
      Given I am on the directory page
      Then I should see "Directory"
      And I should see a button with "/"
      And I should see the contents of directory "/"
