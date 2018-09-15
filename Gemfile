source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Puma tasks for Mina
gem 'mina-puma', require: false
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# The administration framework for Ruby on Rails applications
gem 'activeadmin'
gem 'active_admin_theme'
# Trumbowyg Editor for ActiveAdmin
gem 'activeadmin_trumbowyg'
# Flexible authentication solution for Rails with Warden
gem 'devise'
# A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard
gem 'jwt'
# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'
# Roo provides an interface to spreadsheets of several sorts
gem 'roo'
# A lightning fast JSON:API serializer for Ruby Objects
gem 'fast_jsonapi'
# Audited (formerly acts_as_audited) is an ORM extension that logs all changes to your Rails models.
gem 'audited'
# Annotate Rails classes with schema and routes info
gem 'annotate'
# A library for generating fake data such as names, addresses, and phone numbers.
gem 'faker'
# A Ruby gem to load environment variables from `.env`
gem 'dotenv-rails'
# Your Rails variables in your JS
gem 'gon'

group :development, :test do
  # A Ruby static code analyzer, based on the community Ruby style guide
  gem 'rubocop'
  # Testing framework for Rails 3.x, 4.x and 5.x.
  gem 'rspec-rails', '~> 3.8'
  # Pretty print your Ruby objects with style - in full color and with proper indentation
  gem 'awesome_print'
  # An IRB alternative and runtime developer console
  gem 'pry'
  # A web interface for browsing Ruby on Rails sent emails
  gem 'letter_opener_web'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Help to kill N+1 queries and unused eager loading
  gem 'bullet', '>= 5.7.1'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Strategies for cleaning databases in Ruby
  gem 'database_cleaner'
  # Code coverage with a powerful configuration library and automatic merging of coverage across test suites
  gem 'simplecov', require: false
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
