source "http://rubygems.org"
ruby "2.1.2"
#ruby-gemset=shopping-api

gem "rails", "4.1.4"

gem "unicorn"         # App server
gem "pg"              # DBMS

gem "rails-api", ">= 0.2.1"

gem "pundit"

gem "sidetiq"
gem "sidekiq", ">= 3.2.5"
gem 'sinatra', '>= 1.3.0', require: nil
gem "rest-client", ">= 1.7.2"

gem "kaminari", ">= 0.16.1"

group :development do
  # prettier error page
  gem "better_errors"
  gem "binding_of_caller"

  gem "spring"

  gem "annotate", ">=2.6.3" # Annotate models
end

group :test do
  gem "rspec-rails"#, ">= 3.1.0"
  gem "factory_girl_rails"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
