def test_open_playwright_site(page):
    page.goto("https://playwright.dev")
    page.screenshot(path="playwright_dev.png")
    assert "Fast and reliable end-to-end" in page.title()