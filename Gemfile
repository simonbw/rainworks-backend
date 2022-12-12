source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'dotenv-rails', groups: [:development, :test]

gem 'rails', '~> 6.0.2.rc1'
gem 'pg'
gem 'puma', '~> 3.11'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'administrate'
gem 'administrate-field-enum', git: "https://github.com/guillaumemaka/administrate-field-enum.git", branch: "master"
gem 'administrate-field-lat_lng'
gem 'administrate-field-image'

gem 'aws-sdk'

gem 'exponent-server-sdk'

gem 'attribute-defaults'

gem 'counter_culture'

gem 'dragonfly', '~> 1.1.5'
gem 'dragonfly-s3_data_store'
gem 'mime-types'
gem 'sendgrid-ruby'