class Project
  include Tracker
  attr_accessor :client, :wrapped

  def projects(opts={})
    @projects ||= client.projects.map{|proj| Project.new(proj)}
  end

  def stories(opts={})
    @stories ||= client.projects.first.stories.select{|s| (['nes','enes'] & s.labels.map(&:name)).size > 0}
    opts[:epic].nil? ? @stories : @stories.select{|s| s.labels.select{|l| l.name.downcase == "#{opts[:epic].downcase}"}.size > 0}
  end

end
