@dashboard
Feature: Dashboard page

@dashboard_page
Scenario: Verify dashboard page
    Given login to SWAG_LAB with "standard_user" account
    When waiting for 5 seconds
    Then verify element "dashboard_page/menu_button" is displayed
    And verify element "dashboard_page/header_text_home" is equal to translation "header_text_home"
    And verify element "dashboard_page/cart_button" is displayed
    And verify element "dashboard_page/title_text_product" is equal to translation "title_text_product"
    And verify element "dashboard_page/filter_container" is displayed
    And verify text "filter_text" is displayed

    ## PRODUCTS ##
    And verify element "dashboard_page/img_product_1" is displayed
    And verify element "dashboard_page/title_product_1" is displayed
    And verify element "dashboard_page/desc_product_1" is displayed
    And verify element "dashboard_page/price_product_1" is displayed
    And verify element "dashboard_page/btn_add_to_cart_product_1" is equal to translation "btn_add_to_cart"

    And verify element "dashboard_page/img_product_2" is displayed
    And verify element "dashboard_page/title_product_2" is displayed
    And verify element "dashboard_page/desc_product_2" is displayed
    And verify element "dashboard_page/price_product_2" is displayed
    And verify element "dashboard_page/btn_add_to_cart_product_2" is equal to translation "btn_add_to_cart"

    And verify element "dashboard_page/img_product_3" is displayed
    And verify element "dashboard_page/title_product_3" is displayed
    And verify element "dashboard_page/desc_product_3" is displayed
    And verify element "dashboard_page/price_product_3" is displayed
    And verify element "dashboard_page/btn_add_to_cart_product_3" is equal to translation "btn_add_to_cart"

    And verify element "dashboard_page/img_product_4" is displayed
    And verify element "dashboard_page/title_product_4" is displayed
    And verify element "dashboard_page/desc_product_4" is displayed
    And verify element "dashboard_page/price_product_4" is displayed
    And verify element "dashboard_page/btn_add_to_cart_product_4" is equal to translation "btn_add_to_cart"

    When scroll down website page 3 times

    Then verify element "dashboard_page/img_product_5" is displayed
    And verify element "dashboard_page/title_product_5" is displayed
    And verify element "dashboard_page/desc_product_5" is displayed
    And verify element "dashboard_page/price_product_5" is displayed
    And verify element "dashboard_page/btn_add_to_cart_product_5" is equal to translation "btn_add_to_cart"

    And verify element "dashboard_page/img_product_6" is displayed
    And verify element "dashboard_page/title_product_6" is displayed
    And verify element "dashboard_page/desc_product_6" is displayed
    And verify element "dashboard_page/price_product_6" is displayed
    And verify element "dashboard_page/btn_add_to_cart_product_6" is equal to translation "btn_add_to_cart"

    ## FOOTER ##
    And verify element "dashboard_page/twitter_button" is displayed
    And verify element "dashboard_page/facebook_button" is displayed
    And verify element "dashboard_page/linkedin_button" is displayed
    And verify text "footer_text" is displayed


@dashboard_filter
Scenario: Verify filter product in dashboard page
    Given login to SWAG_LAB with "standard_user" account
    When waiting for 5 seconds
    And click "dashboard_page/filter_container"
    And waiting for 3 seconds
    Then verify text "filter_a_to_z" is displayed
    And verify text "filter_z_to_a" is displayed
    And verify text "filter_price_low_to_high" is displayed
    And verify text "filter_price_high_to_low" is displayed
    
    When click element with text "title_text_product"
    And select "filter_a_to_z" in dropdown "dashboard_page/dropdown_sort_filter"
    And waiting for 3 seconds
    Then verify element "dashboard_page/first_order_product" is equal to translation "backpack_product"

    When click "dashboard_page/filter_container"
    And waiting for 3 seconds
    And click element with text "filter_z_to_a"
    And waiting for 3 seconds
    Then verify element "dashboard_page/first_order_product" is equal to translation "tshirt_product"

    When click "dashboard_page/filter_container"
    And waiting for 3 seconds
    And click element with text "filter_price_low_to_high"
    And waiting for 3 seconds
    Then verify element "dashboard_page/first_order_product" is equal to translation "onesie_product"

    When click "dashboard_page/filter_container"
    And waiting for 3 seconds
    And click element with text "filter_price_high_to_low"
    And waiting for 3 seconds
    Then verify element "dashboard_page/first_order_product" is equal to translation "jacket_product"

@sidebar_section
Scenario: Verify sidebar section
    Given login to SWAG_LAB with "standard_user" account
    When click "dashboard_page/menu_button"
    And waiting for 5 seconds
    Then verify element "dashboard_page/sidebar_cross_btn" is displayed
    And verify element "dashboard_page/sidebar_all_items_btn" is equal to translation "sidebar_all_items_btn"
    And verify element "dashboard_page/sidebar_about_btn" is equal to translation "sidebar_about_btn"
    And verify element "dashboard_page/sidebar_logout_btn" is equal to translation "sidebar_logout_btn"
    And verify element "dashboard_page/sidebar_reset_app_btn" is equal to translation "sidebar_reset_app_btn"

    When click "dashboard_page/sidebar_cross_btn"
    And waiting for 3 seconds
    Then verify element "dashboard_page/sidebar_cross_btn" is not displayed

    When click "dashboard_page/menu_button"
    And click "dashboard_page/sidebar_about_btn"
    And waiting for 3 seconds
    Then verify success direct to link "saucelabs_web"

    When goes back to previous page
    And click "dashboard_page/menu_button"
    And click "dashboard_page/sidebar_logout_btn"
    And waiting for 3 seconds
    Then verify element "login_page/login_button" is displayed

@add_and_remove_product_to_cart
Scenario: Verify user success added prodcut from dashboard to cart
    Given login to SWAG_LAB with "standard_user" account
    When waiting for 3 seconds

    Then verify element "dashboard_page/shopping_cart_bedge" is not displayed
    When click "dashboard_page/btn_add_to_cart_product_1"
    And waiting for 3 seconds
    Then verify element "dashboard_page/shopping_cart_bedge" is displayed
    And verify element "dashboard_page/btn_remove_product_1" is displayed

    When save value of the element "dashboard_page/shopping_cart_bedge"
    And click "dashboard_page/btn_add_to_cart_product_2"
    And waiting for 3 seconds
    Then verify element "dashboard_page/btn_remove_product_2" is displayed
    And verify saved value 1 is lower than with value element "dashboard_page/shopping_cart_bedge"

    When save value of the element "dashboard_page/shopping_cart_bedge"
    And click "dashboard_page/btn_remove_product_2"
    And waiting for 3 seconds
    Then verify element "dashboard_page/btn_add_to_cart_product_2" is displayed
    And verify saved value 2 is more than with value element "dashboard_page/shopping_cart_bedge"
