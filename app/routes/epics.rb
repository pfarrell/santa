class App < Sinatra::Application

  def epics(stories)
    epic_labels = @@project.epics.map{|x| x.label.name}
    epics=Hash.new{|h,k| h[k] = []}
    stories.each do |story|
      story.labels.each do |label|
        epics[label] << story if epic_labels.include?(label.name)
      end
    end
    epics
  end

  def epic(name, stories)
    ret={}
    ret[:epic] = @@project.epics(fields: ':default').select{|e| e.label.name == name }.first
    ret[:stories] = stories.select{|story| story.labels.map(&:name).include?(name)}
    ret
  end

  get '/epic' do
    byebug
    @breadcrumbs << Breadcrumb.new(path: "/epic", display: "epic")
    haml :project, locals: { model: @@project, epics: epics(@@stories) }
  end

  get '/epic/:name' do
    epic = epic(params[:name], @@stories)
    @breadcrumbs << Breadcrumb.new(path: '/epic', display: 'epic')
    @breadcrumbs << Breadcrumb.new(path: "/pic/#{epic[:epic].name}", display: "#{epic[:epic].name}")
    haml :epic, locals: { model: epic }
  end

end
