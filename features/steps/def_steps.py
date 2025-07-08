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


############################################################################################################
#
# Function  :   Open Website
# Example   :   Given user open SWAG_LAB web
#
############################################################################################################
@given('user open SWAG_LAB web')
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
# Example   :   And user fill "[selector_path]" with "[translation_path]"
#
############################################################################################################
@when('user fill "{selector_path}" with "{value}"')
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
# Example   :   And user click "[selector_path]"
#
############################################################################################################
@when('user click "{selector_path}"')
def step_click_element(context, selector_path):
    by, locator = load_selectors(selector_path)

    element = WebDriverWait(context.driver, 10).until(EC.element_to_be_clickable((by, locator)))
    element.click()



############################################################################################################
#
# Function  :   Verify element is displayed
# Example   :   And user verify element "[selector_path]" is displayed
#
############################################################################################################
@then('user verify element "{selector_path}" is displayed')
def step_verify_element_displayed(context, selector_path):
    by, locator = load_selectors(selector_path)

    try:
        element = WebDriverWait(context.driver, 10).until(
            EC.visibility_of_element_located((by, locator))
        )
    except:
        raise AssertionError(f"Element '{selector_path}' is not displayed on the page.")



############################################################################################################
#
# Function  :   Verify text is displayed
# Example   :   And user verify text "[translation_path]" is displayed
#
############################################################################################################
@then('user verify text "{translation_key}" is displayed')
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
# Example   :   And user waiting for 5 seconds
#
############################################################################################################
@when('user waiting for {seconds:d} seconds')
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