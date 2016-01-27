ruby '2.2.3'

source 'https://rubygems.org' do

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '4.2.5.1'
# Use sqlite3 as the database for Active Record
  gem 'sqlite3', group: [:development, :test]
# Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails'

# Use jquery as the JavaScript library
  gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0', group: :doc

  gem 'quiet_assets'
  gem 'semantic-ui-sass'
  gem 'slim-rails'
  gem 'local_time'
  gem 'opal-rails'
  gem 'opal-browser'
  gem 'activerecord-colored_log_subscriber'
  gem 'backup'
  gem 'nprogress-rails'
  gem 'flag_shih_tzu'
  gem 'piwik_analytics'
  gem 'language_list'

  gem 'rack-contrib' # for Rack::Locale
  gem 'rails-i18n'

  gem "refile", require: "refile/rails"
  gem "refile-mini_magick"

# Use ActiveModel has_secure_password
  gem 'bcrypt', '~> 3.1.7'

  group :production do
    gem 'puma'
    gem 'pg'
    gem 'rails_stdout_logging'
  end

  group :development do
    # Access an IRB console on exception pages or by using <%= console %> in views
    gem 'better_errors'
    gem 'binding_of_caller'

    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
  end

  group :test do
    gem 'minitest-rails'

    gem 'coveralls', require: false
  end
end
source 'https://rails-assets.org' do
  gem 'rails-assets-animate.css'
  gem 'rails-assets-alertifyjs'
end
