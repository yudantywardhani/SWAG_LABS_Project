@login
Feature: Dashboard page

@dashboard_page
Scenario: Verify login page
    Given user login to SWAG_LAB with "standard_user" account
    When user waiting for 5 seconds
    Then user verify element "dashboard_page/menu_button" is displayed
    And user verify text "header_text_home" is displayed
    And user verify element "dashboard_page/cart_button" is displayed
    And user verify text "title_text_product" is displayed
    And user verify element "dashboard_page/filter_container" is displayed
    And user verify text "filter_text" is displayed

    ## PRODUCTS ##
    And user verify element "dashboard_page/img_product_1" is displayed
    And user verify element "dashboard_page/title_product_1" is displayed
    And user verify element "dashboard_page/desc_product_1" is displayed
    And user verify element "dashboard_page/price_product_1" is displayed
    And user verify element "dashboard_page/btn_add_to_cart_product_1" is displayed

    And user verify element "dashboard_page/img_product_2" is displayed
    And user verify element "dashboard_page/title_product_2" is displayed
    And user verify element "dashboard_page/desc_product_2" is displayed
    And user verify element "dashboard_page/price_product_2" is displayed
    And user verify element "dashboard_page/btn_add_to_cart_product_2" is displayed

    And user verify element "dashboard_page/img_product_3" is displayed
    And user verify element "dashboard_page/title_product_3" is displayed
    And user verify element "dashboard_page/desc_product_3" is displayed
    And user verify element "dashboard_page/price_product_3" is displayed
    And user verify element "dashboard_page/btn_add_to_cart_product_3" is displayed

    And user verify element "dashboard_page/img_product_4" is displayed
    And user verify element "dashboard_page/title_product_4" is displayed
    And user verify element "dashboard_page/desc_product_4" is displayed
    And user verify element "dashboard_page/price_product_4" is displayed
    And user verify element "dashboard_page/btn_add_to_cart_product_4" is displayed

    When scroll down website page 3 times

    Then user verify element "dashboard_page/img_product_5" is displayed
    And user verify element "dashboard_page/title_product_5" is displayed
    And user verify element "dashboard_page/desc_product_5" is displayed
    And user verify element "dashboard_page/price_product_5" is displayed
    And user verify element "dashboard_page/btn_add_to_cart_product_5" is displayed

    And user verify element "dashboard_page/img_product_6" is displayed
    And user verify element "dashboard_page/title_product_6" is displayed
    And user verify element "dashboard_page/desc_product_6" is displayed
    And user verify element "dashboard_page/price_product_6" is displayed
    And user verify element "dashboard_page/btn_add_to_cart_product_6" is displayed

    ## FOOTER ##
    And user verify element "dashboard_page/twitter_button" is displayed
    And user verify element "dashboard_page/facebook_button" is displayed
    And user verify element "dashboard_page/linkedin_button" is displayed
    And user verify text "footer_text" is displayed