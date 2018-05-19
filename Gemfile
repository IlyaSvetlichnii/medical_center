source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem "pg", "~> 0.21"
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "interactor-rails"
gem 'bcrypt', '~> 3.1.7'
gem 'active_model_serializers'
gem 'activeadmin'
gem 'active_admin_flat_skin'
gem 'devise'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'mina'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'capistrano', '>= 3.2.1'
  gem 'capistrano-rbenv', '~> 2.0'           # idiomatic rbenv support
  gem 'capistrano-rbenv-install'             # ensures the right ruby version is installed
  gem 'capistrano-bundler', '~> 1.1.2'       # support for bundler
  gem 'capistrano-rails', '~> 1.0'           # automatic migrations and asset compilation
  gem 'capistrano-unicorn-nginx', '~> 2.0'   # plug-n-play nginx and unicorn
  gem 'capistrano-postgresql', '~> 3.0'      # plug-n-play postgresql
  gem 'capistrano-safe-deploy-to', '~> 1.1'  # ensures deploy path for the app exists
  gem 'capistrano-ssh-doctor'                # helps with debugging ssh-agent forwarding
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-expectations'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'json_spec'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
