class App < Sinatra::Application
  def epics(stories)
    #byebug
    epic_labels = @@project.epics.map{|x| x.label.name}
    epics=Hash.new{|h,k| h[k] = []}
    stories.each do |story|
      story.labels.each do |label|
        epics[label] << story if epic_labels.include?(label.name)
      end
    end
    epics
  end

  get '/project' do
    haml :projects, locals: {models: [@@project]}
  end

  get '/project/:name' do
    haml :project, locals: { model: @@project, epics: epics(@@stories) }
  end
end
