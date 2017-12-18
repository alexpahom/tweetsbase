source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'autoprefixer-rails'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder',     '~> 2.5'
gem 'jquery-rails'
gem 'pg',          '~> 0.18'
gem 'puma',        '~> 3.7'
gem 'rails',       '~> 5.1.4'
gem 'sass-rails',  '~> 5.0'
gem 'turbolinks',   '~> 5'
gem 'uglifier', '>= 1.3.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'bcrypt',       '~> 3.1.7'
gem 'rails-html-sanitizer'
gem 'rails-controller-testing'
gem 'rubocop',      '~> 0.51.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'capybara', '~> 2.13'
  gem 'pry'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
