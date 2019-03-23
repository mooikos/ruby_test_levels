class Driver
  def session_get
    chrome_options = {}
    chrome_options['args'] = ['--window-size=10000,10000']
    logging_prefs = { performance: 'ALL' }
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: chrome_options,
      loggingPrefs: logging_prefs
    )

    Selenium::WebDriver.for(:chrome,
                            desired_capabilities: capabilities)
  end
end
