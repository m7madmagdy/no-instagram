source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem 'pg', '~> 1.4'
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'httparty'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'devise', '~> 4.9', '>= 4.9.2'
gem 'followability', github: 'nejdetkadir/followability', branch: 'main'

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
gem 'tzinfo-data', platforms: %I[mingw mswin x64_mingw jruby]