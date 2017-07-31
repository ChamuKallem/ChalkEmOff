# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

# require_relative 'rack/cors'
# use Rack::Cors do
#   allow do
#       origins '*'
#       resource '*',
#         :headers => :any,
#         :expose  => ['access-token', 'token-type', 'uid', 'client', 'expiry'],
#         :methods => [:get, :post, :put, :delete, :options]
#     end
# end
