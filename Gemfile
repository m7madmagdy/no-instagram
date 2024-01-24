source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap', require: false
gem 'devise', '~> 4.9', '>= 4.9.2'
gem 'followability', github: 'nejdetkadir/followability', branch: 'main'
gem 'httparty'
gem 'importmap-rails'
gem 'jbuilder'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'pg', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'ransack' # search
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platforms: %I[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
end
