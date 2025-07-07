@login
Feature: Login to SauceDemo

@login_page
Scenario: Verify login page
    Given user open SWAG_LAB web
    When user waiting for 5 seconds
    Then user verify text "header_login_page" is displayed
    And user verify element "login_page/username_field" is displayed
    And user verify element "login_page/password_field" is displayed
    And user verify element "login_page/login_button" is displayed
    And user verify element "login_page/login_list_username" is displayed
    And user verify element "login_page/login_list_password" is displayed

@login_success
Scenario: Successful login
    Given user open SWAG_LAB web
    When user waiting for 5 seconds
    And user fill "login_page/username_field" with "username"
    And user fill "login_page/password_field" with "password"
    And user click "login_page/login_button"
    And user waiting for 5 seconds
    Then user verify element "dashboard_page/shopping_chart" is displayed

@login_failed_invalid_username
Scenario: Failed login with invalid username
    Given user open SWAG_LAB web
    When user fill "login_page/username_field" with "invalid_username"
    And user fill "login_page/password_field" with "password"
    And user click "login_page/login_button"
    And user waiting for 5 seconds
    Then user verify element "login_page/wrong_username_icon" is displayed
    And user verify element "login_page/wrong_password_icon" is displayed
    And user verify text "error_login_message" is displayed
    And user verify element "login_page/error_icon" is displayed

@login_failed_invalid_password
Scenario: Failed login with invalid username
    Given user open SWAG_LAB web
    When user fill "login_page/username_field" with "username"
    And user fill "login_page/password_field" with "invalid_password"
    And user click "login_page/login_button"
    And user waiting for 5 seconds
    Then user verify element "login_page/wrong_username_icon" is displayed
    And user verify element "login_page/wrong_password_icon" is displayed
    And user verify text "error_login_message" is displayed
    And user verify element "login_page/error_icon" is displayed