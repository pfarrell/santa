class App < Sinatra::Application

  def epic(name, stories)
    ret={}
    ret[:epic] = @@project.epics.select{|e| e.label.name == name }.first
    ret[:stories] = stories.select{|story| story.labels.map(&:name).include?(name)}
    ret
  end

  get '/epic/:name' do
    haml :epic, locals: { model: epic(params[:name], @@stories) }
  end

end
