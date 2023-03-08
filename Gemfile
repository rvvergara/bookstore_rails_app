source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'
gem 'rails', '>= 6.1', '< 6.2'
gem 'pg', '= 1.2.3'
gem 'puma', '~> 4.3'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'jwt'
gem 'pundit'
gem 'jbuilder', '~> 2.5'
gem 'rack-cors'
gem 'pg_search'

group :development, :test do
  gem 'hirb'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'spring-commands-rspec'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'pundit-matchers', '~> 1.6.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
