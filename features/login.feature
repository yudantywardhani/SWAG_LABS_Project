@login
Feature: Login to SauceDemo

@login_page
Scenario: Verify login page
    Given open SWAG_LAB web
    When waiting for 5 seconds
    Then verify text "header_login_page" is displayed
    And verify element "login_page/username_field" is displayed
    And verify element "login_page/password_field" is displayed
    And verify element "login_page/login_button" is displayed
    And verify element "login_page/login_list_username" is displayed
    And verify element "login_page/login_list_password" is displayed

@login_success
Scenario: Successful login
    Given open SWAG_LAB web
    When waiting for 5 seconds
    And fill "login_page/username_field" with "username"
    And fill "login_page/password_field" with "password"
    And click "login_page/login_button"
    And waiting for 5 seconds
    Then verify element "dashboard_page/shopping_chart" is displayed

@login_failed_invalid_username
Scenario: Failed login with invalid username
    Given open SWAG_LAB web
    When fill "login_page/username_field" with "invalid_username"
    And fill "login_page/password_field" with "password"
    And click "login_page/login_button"
    And waiting for 5 seconds
    Then verify element "login_page/wrong_username_icon" is displayed
    And verify element "login_page/wrong_password_icon" is displayed
    And verify text "error_login_message" is displayed
    And verify element "login_page/error_icon" is displayed

@login_failed_invalid_password
Scenario: Failed login with invalid username
    Given open SWAG_LAB web
    When fill "login_page/username_field" with "username"
    And fill "login_page/password_field" with "invalid_password"
    And click "login_page/login_button"
    And waiting for 5 seconds
    Then verify element "login_page/wrong_username_icon" is displayed
    And verify element "login_page/wrong_password_icon" is displayed
    And verify text "error_login_message" is displayed
    And verify element "login_page/error_icon" is displayed