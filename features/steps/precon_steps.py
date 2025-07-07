import time
from behave import given
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from features.utils.helpers import *

@given('user login to SWAG_LAB with "{account}" account')
def step_user_login_with_account(context, account):

    context.execute_steps('''
        Given user open SWAG_LAB web
        When user waiting for 5 seconds
    ''')

    username, password = load_test_data(account)

    element = WebDriverWait(context.driver, 10).until(EC.presence_of_element_located((By.ID, "user-name")))
    element.clear()
    element.send_keys(username)
    time.sleep(3)

    element = WebDriverWait(context.driver, 10).until(EC.presence_of_element_located((By.ID, "password")))
    element.clear()
    element.send_keys(password)
    time.sleep(3)

    context.execute_steps('''
        When user click "login_page/login_button"
        And user waiting for 5 seconds
    ''')

