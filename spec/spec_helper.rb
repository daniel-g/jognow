ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.include FactoriesHelpers
  config.include BecomeTrueMatcher
  Capybara.javascript_driver = :webkit

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
    begin
      DatabaseCleaner.start
      # FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before :each, type: :feature do |example|
    if example.metadata[:js]
      Capybara.current_driver = :webkit
      if example.metadata[:selenium]
        Capybara.current_driver = :selenium
      end
    end
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
