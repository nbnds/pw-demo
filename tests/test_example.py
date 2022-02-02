import allure

def test_open_playwright_site(page):
    page.goto("https://playwright.dev")
    screemshot_bytes = page.screenshot()
    assert "Fast and reliable end-to-end" in page.title()
    allure.attach(screemshot_bytes, name="Screenshot", attachment_type=allure.attachment_type.PNG)