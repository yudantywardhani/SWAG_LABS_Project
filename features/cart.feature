@cart
Feature: Cart page

@cart_page
Scenario: Verify Cart page
    Given login to SWAG_LAB with "standard_user" account
    When waiting for 5 seconds
    And save text of the element "dashboard_page/desc_product_1"
    And save text of the element "dashboard_page/price_product_1"

    And click "dashboard_page/btn_add_to_cart_product_1"
    And click "dashboard_page/cart_button"
    And waiting for 5 seconds

    Then verify element "cart_page/menu_button" is displayed
    And verify element "cart_page/header_text_home" is equal to translation "header_text_home"
    And verify element "cart_page/cart_button" is displayed
    And verify element "cart_page/title_text_cart" is equal to translation "title_text_cart"

    And verify element "cart_page/qty_label" is equal to translation "qty_label"
    And verify element "cart_page/desc_label" is equal to translation "desc_label"
    And verify element "cart_page/product_quantity" is displayed
    And verify text "backpack_product" is displayed
    And verify saved value 1 is equals to with text element "cart_page/desc_product_1"
    And verify saved value 2 is equals to with text element "cart_page/price_product_1"
    And verify element "cart_page/remove_button_product_1" is displayed
    And verify element "cart_page/back_icon" is displayed
    And verify text "continue_shopping_button" is displayed
    And verify element "cart_page/checkout_button" is equal to translation "checkout_button"

@remove_product_from_cart
Scenario: Verify the product not displayed after clicks on remove button
    Given login to SWAG_LAB with "standard_user" account
    When waiting for 5 seconds

    And click "dashboard_page/btn_add_to_cart_product_1"
    And click "dashboard_page/btn_add_to_cart_product_2"
    And save value of the element "dashboard_page/shopping_cart_bedge"
    And click "dashboard_page/cart_button"
    And waiting for 5 seconds
    And save text of the element "dashboard_page/desc_product_2"

    Then verify saved value 2 is equals to with text element "cart_page/desc_product_2"
    When click "cart_page/remove_button_product_2"
    Then verify element "cart_page/desc_product_2" is not displayed
    And verify saved value 1 is more than with value element "dashboard_page/shopping_cart_bedge"

@navigation_cart_page
Scenario: Verify navigation for cart page when click on Continue or Checkout button
    Given login to SWAG_LAB with "standard_user" account

    When waiting for 5 seconds
    And click "dashboard_page/btn_add_to_cart_product_1"
    And click "dashboard_page/btn_add_to_cart_product_2"
    And click "dashboard_page/cart_button"
    And waiting for 5 seconds
    Then verify element "cart_page/title_text_cart" is equal to translation "title_text_cart"

    When click "cart_page/back_icon"
    And waiting for 5 seconds
    Then verify element "dashboard_page/title_text_product" is equal to translation "title_text_product"

    When click "cart_page/cart_button"
    And waiting for 5 seconds
    And click "cart_page/checkout_button"
    And waiting for 5 seconds
    Then verify element "checkout_page/title_text_checkout" is equal to translation "title_text_checkout"
