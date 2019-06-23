source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'
gem 'dotenv-rails', groups: [:development, :test]
gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bcrypt'
gem 'jwt'
gem 'active_model_serializers', '~> 0.10.0'
gem 'geocoder'

gem 'activestorage-imgur', :git => 'https://github.com/muyaszed/activestorage-imgur.git', :branch => 'master'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

gem 'koala'


#this gem is for tweaking activestorage-imgur
gem "down", "~> 4.4"
gem 'imgurapi'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails' #added for testing
  
end

group :test do #added for testing
  gem 'factory_bot_rails'#added for testing
  gem 'shoulda-matchers'#added for testing
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'#added for testing
  gem 'database_cleaner'#added for testing
  gem 'webmock'
end#added for testing

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
