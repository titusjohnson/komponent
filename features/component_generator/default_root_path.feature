Feature: Component generator - Default root path

  Scenario: Component
    Given I run `rails new my_app --skip-spring`
    And I cd to "my_app"
    And I append to "Gemfile" with:
    """
    gem 'komponent', path: '../../..'
    """
    And a file named "config/initializers/custom_configuration.rb" with:
    """
    Rails.application.config.komponent.root = Rails.root.join("app/frontend")
    """
    When I run `bundle install`
    And I run `rails webpacker:install`
    And I run `rails generate komponent:install`
    And I run `rails generate component AwesomeButton`
    And I cd to "app/frontend/components"
    Then the following files should exist:
      | awesome_button/_awesome_button.html.erb     |
      | awesome_button/awesome_button.scss          |
      | awesome_button/awesome_button.js            |
      | awesome_button/awesome_button_component.rb  |
    And the file named "index.js" should contain:
    """
    import "components/awesome_button/awesome_button";
    """

