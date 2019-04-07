# frozen_string_literal: true

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server = :puma, { Silent: true }
