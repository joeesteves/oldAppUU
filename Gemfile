source 'https://rubygems.org'

gem 'rails', '4.2.3'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'

gem 'active_model_serializers'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'puma'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Seguridad
gem 'devise_token_auth', git: 'https://github.com/lynndylanhurley/devise_token_auth.git'
gem 'omniauth'

# Bower para manejar las dependencias de JS

gem 'bower-rails'

# Haml HTML DSL

gem "haml-rails"
# locked porque la nueva version tiene un problema con Rails.application.assets.register_engine esperar que lo solucionen
gem 'sprockets-rails', '~> 2.3'

group :development, :test do
  # gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.0', require: false
  # gem 'factory_girl_rails'
  gem 'guard-rspec', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'

end
