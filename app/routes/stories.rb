class App < Sinatra::Application
  get '/story/:id' do
    haml :story, locals: { model: story }
  end
end
