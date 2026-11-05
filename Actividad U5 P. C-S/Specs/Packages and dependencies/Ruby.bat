# Servidor RESTful (Sinatra)
cd ruby/rest-service
bundle init
# Gemfile adiciona: gem 'sinatra', gem 'puma', gem 'jwt', gem 'rswag'
bundle install

# Servidor SOAP (WashOut / Rack SOAP)
cd ../soap-service
bundle init
# Gemfile adiciona: gem 'wash_out' O gem 'savon', gem 'rack'
bundle install

# Cliente
cd ../client
bundle init
# Gemfile adiciona: gem 'httparty', gem 'savon'
bundle install