require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sample
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.app_generators.javascript_engine :coffeescript
    config.assets.enabled = true
    def get_token
      return @jupyter_access_cookie unless @jupyter_access_cookie.nil?
      login_path = "http://localhost:8888/login"
      response = HTTP.get login_path
      cookie = response.cookies.cookies[0]
      payload = { cookie.name => cookie.value, "password" => "railsjupyter" }
      reponse = HTTP.cookies(cookie.name => cookie.value).post(login_path, :form => payload)
      cookie = reponse.cookies.cookies[0]
      @jupyter_access_cookie = { cookie.name => cookie.value }
      return @jupyter_access_cookie
    end
  end
end
