class App < Sinatra::Application
  get "/" do
    require 'byebug'
    byebug
    haml :index
  end
end
