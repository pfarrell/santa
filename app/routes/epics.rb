class App < Sinatra::Application

  def epic(name, stories)
    ret={}
    ret[:epic] = @@project.epics.select{|e| e.label.name == name }.first
    ret[:stories] = stories.select{|story| story.labels.map(&:name).include?(name)}
    ret
  end

  get '/epic/:name' do
    epic = epic(params[:name], @@stories)
    @breadcrumbs << Breadcrumb.new(path: '/epic', display: 'epic')
    @breadcrumbs << Breadcrumb.new(path: "/pic/#{epic[:epic].name}", display: "#{epic[:epic].name}")
    haml :epic, locals: { model: epic }
  end

end
