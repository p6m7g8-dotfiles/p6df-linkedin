from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from typing import Dict, List
import time

PROFILE_DIR = "/Users/pgollucci/Library/Application Support/Google/Chrome"
CONNECTION_URL = "https://www.linkedin.com/mynetwork/invite-connect/connections/"
SCROLL_PAUSE_TIME = 1


class P6LIBot:
    """ """

    def __init__(self, start_url: str) -> None:
        """ """
        print(f"Initializing P6LIBot with start_url={start_url}...\n")
        self.start_url = start_url
        self.browser = None

    def __enter__(self):
        """ """
        print("Entering P6LIBot...\n")
        ops = Options()
        ops.add_argument(f"--user-data-dir={PROFILE_DIR}")
        ops.add_argument("--profile-directory=Selenium.linkedin")
        ops.add_argument("--disable-gpu")
        # ops.add_argument("--headless")

        self.browser = webdriver.Chrome(options=ops)
        self.browser.get(self.start_url)
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback):
        """ """
        print("Exiting P6LIBot...\n")
        time.sleep(1)
        self.browser.quit()
        self.browser.close()

    def login(self) -> None:
        """ """
        print("Logging in...\n")
        time.sleep(25)

    def peek_at_connections(self) -> None:
        """ """
        print("Peeking at connections...\n")
        self.browser.get(CONNECTION_URL)
        time.sleep(5)
        self.scroll_to_load_all_connections()
        time.sleep(2)
        connections = self.extract_connections()
        time.sleep(2)
        self.view_connections(connections)

    def scroll_to_load_all_connections(self) -> None:
        """ """
        print("Scrolling to load all connections...\n")
        js_script = "document.body.scrollHeight"
        last_height = self.browser.execute_script(f"return {js_script}")
        while True:
            time.sleep(SCROLL_PAUSE_TIME)
            self.browser.execute_script(f"window.scrollTo(0, {js_script});")
            new_height = self.browser.execute_script(f"return {js_script}")
            if new_height == last_height:
                break
            last_height = new_height

    def extract_connections(self) -> List[Dict[str, str]]:
        """ """
        print("Extracting connections...\n")
        ul_xpath = "/html/body/div[4]/div[3]/div/div/div/div/div[2]/div/div/main/div/section/div[2]/div[1]/ul/li"
        connection_elements = self.browser.find_elements(by=By.XPATH, value=ul_xpath)

        connections = []
        for element in connection_elements:
            name = element.find_element(
                by=By.XPATH, value=".//*[contains(@class, 'mn-connection-card__name')]"
            ).text
            occupation = element.find_element(
                by=By.XPATH,
                value=".//*[contains(@class, 'mn-connection-card__occupation')]",
            ).text
            profile_url = element.find_element(
                by=By.XPATH,
                value=".//*[contains(@class, 'mn-connection-card__link')]",
            ).get_attribute("href")

            print(f"{profile_url}")

            connections.append(
                {"name": name, "occupation": occupation, "profile_url": profile_url}
            )
        return connections

    def view_connections(self, connections: List[Dict[str, str]]) -> None:
        """ """
        print("Viewing connections...\n")
        for connection in connections:
            profile_url = connection["profile_url"]
            print(f"{profile_url}")
            self.browser.get(profile_url)
            time.sleep(2)

    def load_profile_urls_from_file(self, file_path: str) -> List[str]:
        """ """
        print("Loading profile_urls from file...\n")
        profile_urls = []
        with open(file_path, "r") as file:
            profile_urls = [url.strip() for url in file.readlines()]
        return profile_urls
