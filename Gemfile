source 'https://rubygems.org'

gem 'dotenv-rails', require: 'dotenv/rails-now'  # provides loading of ENV from .env files per environment

gem 'rails', '4.2.4' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# View Gems
gem 'bootstrap-sass-extras' # provides helpers for use with Bootstrap https://github.com/doabit/bootstrap-sass-extras
gem 'jquery-ui-rails' # provides jQuery UI CSS/JS https://github.com/joliss/jquery-ui-rails
gem 'haml-rails' # replaces ERB with HAML for markup
gem 'sass-rails', '~> 5.0' # use SASS instead of CSS for stylesheets
gem 'bootstrap-sass' # use Bootstrap styling SASS/JS https://github.com/twbs/bootstrap-sass
gem 'bootstrap_form' # Bootstrap helpers for forms https://github.com/bootstrap-ruby/rails-bootstrap-forms
gem 'uglifier', '>= 1.3.0' # use Uglifier for JS assets
gem 'coffee-rails', '~> 4.1.0' # use Coffeescript instead of pure JS
gem 'therubyracer', platforms: :ruby # use for ExecJS
gem 'font-awesome-rails' # includes Font Awesome to Rails asset pipeline
gem 'rails-i18n', '~> 4.0.0' # provides extra locales
gem 'x-editable-rails' # provides inline editable fields
gem 'bootstrap-select-rails', git: 'https://github.com/jh125486/bootstrap-select-rails.git', branch: '1_7_4_with_locales' # provides a nice HTML SELECT element for bootstrap https://github.com/silviomoreto/bootstrap-select

# JS Gems
gem 'jquery-rails', '= 4.0.4' # use Jquery for JS library # > 4.0.4 breaks isArrayLike for Datatables
gem 'turbolinks' # turbolinks for Pcaching
gem 'jquery-turbolinks' # makes turbolinks play nice with jQuery
gem 'jquery-datatables-rails' # adds jQuery datatables JS https://www.datatables.net/
gem 'ajax-datatables-rails' # provides server-side interaction with jQuery datatables
gem 'momentjs-rails' # provides local time formatted JS strings http://momentjs.com/
gem 'rails-livestamp' # provides auto-updating timestamps w/momentjs
gem 'bootstrap_tokenfield_rails'  # provides bootstrap tokenfield http://sliptree.github.io/bootstrap-tokenfield/
gem 'bootstrap-datepicker-rails' # provides datepicker from https://github.com/eternicode/bootstrap-datepicker
gem 'bootstrap-slider-rails' # provides slider from http://www.eyecon.ro/bootstrap-slider/
gem 'i18n-js', '>= 3.0.0.rc11' # provides some I18n translations

# Model Gems
gem 'jbuilder', '~> 2.0' # JSON builder for API
gem 'responders' # externalized in Rails 4.2
gem 'acts-as-taggable-on' # provides methods for tagging of models
gem 'aasm' # provides methods for State Machine events and callbacks
gem 'friendly_id' # provides readable ids for URL params
gem 'kaminari' # provides Model pagination

# Server Gems
gem 'pg' # Use Postgres as database
gem 'puma' # multiple request concurrency webserver

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development, :test do
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3' # used for local development adn testing
  gem 'factory_girl_rails' # replaces fixtures with factories
  gem 'awesome_print' # provides 'ap' method for printing out deep structures in a clearer format
  gem 'railroady' # generates UML for models/controllers
  gem 'guard' # autorun tests after changes are made
end
gem 'guard-minitest' # integrates guard with minitest
gem 'minitest-reporters' # integrates test view with intelliJ
gem 'dotenv-rails' # provides environment variable loading

group :development do
  gem 'web-console', '~> 2.0' # access IRB on exception page, or '= console' in views
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
end

group :test do
  gem 'rubocop', require: false # static code analyzer
  gem 'haml-lint', require: false # HAML analyzer
  gem 'scss_lint', require: false # SASS static analyzer
  gem 'brakeman', require: false # provides vulnerability analysis
  gem 'simplecov' # coverage reporting
end

group :production do
  gem 'rails_12factor' # enables integration with Heroku asset serving and logging
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows doesn't have time info
