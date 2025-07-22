import json
import os
import time
from behave import given, when, then, step
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from features.utils.helpers import load_selectors, load_translations
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select


############################################################################################################
#
# Function  :   Open Website
# Example   :   Given open SWAG_LAB web
#
############################################################################################################
@given('open SWAG_LAB web')
def step_open_web(context):    
    url = "https://www.saucedemo.com"

    options = Options()
    # options.add_experimental_option("detach", True) # use for not automatically close web

    # to disable the Chrome password manager pop-up
    options.add_experimental_option("prefs", {
        "credentials_enable_service": False,
        "profile.password_manager_enabled": False
    })
    options.add_argument("--disable-save-password-bubble")
    options.add_argument("--incognito") # will be open incognito window

    # Launch browser and open URL
    context.driver = webdriver.Chrome(options=options)
    context.driver.maximize_window()
    context.driver.get(url)


############################################################################################################
#
# Function  :   Fill input to field
# Example   :   And fill "[selector_path]" with "[translation_path]"
#
############################################################################################################
@when('fill "{selector_path}" with "{value}"')
def step_fill_input(context, selector_path, value):
    by, locator = load_selectors(selector_path)

    # Load translations only once
    if not hasattr(context, "translations"):
        context.translations = load_translations()
    
    # Use translation value if available
    if value in context.translations:
        value = context.translations[value]

    element = WebDriverWait(context.driver, 10).until(EC.presence_of_element_located((by, locator)))
    element.clear()
    element.send_keys(value)



############################################################################################################
#
# Function  :   Click element
# Example   :   And click "[selector_path]"
#
############################################################################################################
@when('click "{selector_path}"')
def step_click_element(context, selector_path):
    by, locator = load_selectors(selector_path)

    element = WebDriverWait(context.driver, 10).until(EC.element_to_be_clickable((by, locator)))
    element.click()



############################################################################################################
#
# Function  :   Click element by text
# Example   :   And click "[selector_path]" with text "[translation_path]"
#
############################################################################################################
@when('click element with text "{translation_key}"')
def step_click_element_text(context, translation_key):
    if not hasattr(context, "translations"):
        context.translations = load_translations()
    
    if translation_key not in context.translations:
        raise KeyError(f"Translation key '{translation_key}' not found in translations.json")

    text = context.translations[translation_key]
    text = f"//*[text()='{text}']"

    element = WebDriverWait(context.driver, 10).until(EC.element_to_be_clickable((By.XPATH, text)))
    element.click()
    


############################################################################################################
#
# Function  :   Verify element is displayed
# Example 1 :   And verify element "[selector_path]" is displayed
# Example 2 :   And verify element "[selector_path]" is not displayed
#
############################################################################################################
@then('verify element "{selector_path}" {condition} displayed')
def step_verify_element_displayed(context, selector_path, condition):
    by, locator = load_selectors(selector_path)

    elements = context.driver.find_elements(by, locator)
    is_visible = any(e.is_displayed() for e in elements)

    if condition == "is":
        assert is_visible, f"Element {selector_path} is displayed on screen"
    elif condition == "is not":
        assert not is_visible, f"Element {selector_path} is not displayed on screen"
    else:
        raise ValueError(f"Invalid condition '{condition}', expected 'is' or 'is not'.")
        


############################################################################################################
#
# Function  :   Verify text is displayed
# Example   :   And verify text "[translation_path]" is displayed
#
############################################################################################################
@then('verify text "{translation_key}" is displayed')
def step_verify_text_displayed(context, translation_key):
    # Make sure translations are loaded
    if not hasattr(context, "translations"):
        context.translations = load_translations()
    
    if translation_key not in context.translations:
        raise KeyError(f"Translation key '{translation_key}' not found in translations.json")
    
    expected_text = context.translations[translation_key]

    try:
        WebDriverWait(context.driver, 10).until(EC.presence_of_element_located((By.XPATH, f"//*[contains(normalize-space(.), '{expected_text}')]"))
        )
    except:
        raise AssertionError(f"Text '{expected_text}' is not displayed on the page.")



############################################################################################################
#
# Function  :   for waiting in seconds
# Example   :   And waiting for 5 seconds
#
############################################################################################################
@when('waiting for {seconds:d} seconds')
def step_wait_seconds(context, seconds):
    time.sleep(seconds)



############################################################################################################
#
# Function  :   To scroll down or up the page
# Example   :   And scroll down website page
#
############################################################################################################
@when('scroll {arrow} website page {x:d} times')
def step_wait_seconds(context, arrow, x):
    if arrow not in ["up","down"]:
        raise ValueError("Arrow must be 'up' or 'down'")

    for _ in range (x):
        if arrow == "down":
            context.driver.execute_script("window.scrollBy(0, 500);")
        else:
            context.driver.execute_script("window.scrollBy(0, -500);")
        time.sleep(0.5)



############################################################################################################
#
# Function  :   Verify an element has a correct text
# Example   :   And verify element "[selector_path]" is equal to translation "[translation_path]"
#
############################################################################################################
@then('verify element "{selector_path}" is equal to translation "{translation_key}"')
def step_verify_element_has_text(context, selector_path, translation_key):

    if not hasattr(context, "translations"):
        context.translations = load_translations()
    
    if translation_key not in context.translations:
        raise KeyError(f"Translation key '{translation_key}' not founc in translations.json")
    
    expected_text = context.translations[translation_key]
    by, locator = load_selectors(selector_path)

    try:
        element = WebDriverWait(context.driver, 10). until(EC.visibility_of_element_located((by, locator))
        )
        actual_text = element.text.strip()
    except:
        raise AssertionError(f"Element '{selector_path}' couldn't be located or is not visible")

    if actual_text != expected_text:
        raise AssertionError(f"Expected text '{expected_text}' not equals with actual text '{actual_text}'")    



############################################################################################################
#
# Function  :   Select one of dropdown list by text
# Example   :   And select [translation_path] in dropdown [selector_path]
#
############################################################################################################
@when('select "{translation_key}" in dropdown "{selector_path}"')
def step_select_dropdown(context, translation_key, selector_path):
    by, locator = load_selectors(selector_path)

    translations = load_translations()
    text = translations[translation_key]

    try:
        dropdown_element = WebDriverWait(context.driver, 10).until(EC.element_to_be_clickable((by, locator))
        )
        select = Select(dropdown_element)
        
        found = False
        for option in select.options:
            if option.text == text:
                option.click()
                found = True
                break
        
        if not found:
            raise AssertionError(f"Option '{text}' not found in dropdown")
        

    except Exception as e:
        raise AssertionError(f"Could not select '{text}' from dropdown '{selector_path}'\nError: {e}")

############################################################################################################
#
# Function  :   Verify the user success direct to destination url link
# Example   :   Then verify success direct to link "[translation_key]"
#
############################################################################################################
@Then('verify success direct to link "{translation_key}"')
def direct_to_link(context, translation_key):
    translations = load_translations()

    expected_link = translations[translation_key]
    actual_link = context.driver.current_url

    assert expected_link in actual_link, f"direct to '{expected_link}'"