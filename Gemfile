source 'https://rubygems.org'
ruby '2.1.3'

gem 'rails', '4.1.6'
gem 'jbuilder', '~> 2.0'

# Assets and etc.
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

# Auth
gem 'omniauth'
gem 'omniauth-github'

# External APIs
gem 'soundcloud'

# Settings
gem 'settingslogic'

group :development do
  # Local configuration
  gem 'dotenv-rails'

  # Annotate models
  gem 'annotate'

  # Debuging and profiling
  gem 'awesome_print'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'letter_opener'

  # Code styling
  gem 'rubocop', require: false

  # Guards
  gem 'guard', require: false
  gem 'guard-annotate', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-bundler', require: false
end

group :production do
  gem 'pg'
  gem 'unicorn'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end
