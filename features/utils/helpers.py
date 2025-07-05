# USE FOR HELPER TO REUSE IN ALL STEPS

import os
import json
from selenium.webdriver.common.by import By

def get_base_path():
    # Go to root (WEB BASED)
    return os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))

def load_selectors(project, selector_path):
    page, key = selector_path.split("/")
    base_path = get_base_path()
    selector_file = os.path.join(base_path, "selectors", f"{page}.json")

    with open(selector_file, "r") as f:
        selectors = json.load(f)
    
    if key not in selectors:
        raise Exception(f"Selector '{key}' not found in {selector_file}")
    
    selector = selectors[key]
    by = getattr(By, selector["by"].upper())
    return by, selector["value"]

def load_translations (project):
    base_path = get_base_path()
    file_path = os.path.join(base_path, "translations.json")
    if not os.path.exists(file_path):
        return{}
    with open(file_path, "r") as f:
        return json.load(f)