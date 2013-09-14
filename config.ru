require 'dashing'

configure do
  set :duolingo_user, 'private'
  set :ewsEndpoint, 'https://private.outlook.com/ews/Exchange.asmx'
  set :ewsUser, 'private@private.onmicrosoft.com'
  set :ewsPassword, 'private'
  set :flickr_id, '111111111@N05'
  set :timeZoneBias, 0

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application