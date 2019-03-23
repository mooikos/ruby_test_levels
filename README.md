# idea

have different micro apps tested on different levels (unit, integration, system, system integration)
* there are 3 different apps running here
  * app_frontend
    * ruby based (slim templates) (should/could be substituted from a node app)
    * serves the frontend
  * app_backend
    * ruby based
    * serves the endpoints for the logics
  * app_dependency
    * ruby based
    * serves extra support to the backend app
* the various apps are tested with rspec for now (the frontend app could get unit and integration testing examples in node)

# commands

* start the app to test
  * frontend (inside his folder)
    * ruby app_frontend.rb
    * http://localhost:8080
    * start mock server of the backend
      *
  * backend (inside his folder)
    * ruby app_backend.rb
    * http://localhost:3000/?name=my%20name
  * dependency backend (inside his folder)
    * ruby app_dependency.rb
    * http://localhost:3001
  * mock of backend (for frontend)
    * yarn backend-mockserver
* run tests
  * bundle exec rspec
* see code coverage (in browser)
  * ./coverage/index.html

# the docs of the core dependencies
* web app framework
  * http://sinatrarb.com/intro.html
  * https://www.rubydoc.info/gems/sinatra
* templates for writing frontend files (html, css, javascript)
  * https://www.rubydoc.info/gems/slim/frames
* support for javascript of the frontend
  * https://api.jquery.com
* rest client
  * https://github.com/rest-client/rest-client
* mockserver of the backend app
  * https://www.npmjs.com/package/mockserver
* test framework
  * http://rspec.info/documentation/
* allow disabling network in integration tests
  * https://github.com/bblimke/webmock
* support for backend integration api tests
  * https://github.com/rack-test/rack-test
* browser automation
  * https://seleniumhq.github.io/selenium/docs/api/rb/
* static analysis
  * https://github.com/rubocop-hq/rubocop
* test coverage
  * https://github.com/colszowka/simplecov
