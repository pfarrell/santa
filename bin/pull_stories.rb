require 'tracker_api'
require 'byebug'


class Project
  attr_accessor :client, :stories

  def initialize
    @client=TrackerApi::Client.new(token: ENV['PIVOTAL_TOKEN'])
  end

  def stories(opts={})
    @stories ||= client.projects.first.stories.select{|s| s.labels.select{|l| l.name.downcase == 'nes' || l.name.downcase == 'enes'}.size > 0}
    opts[:epic].nil? ? @stories : @stories.select{|s| s.labels.select{|l| l.name.downcase == "#{opts[:epic].downcase}"}.size > 0}
    #@stories
  end

  def active(opts={})
    stories(opts).reject{|s| s.current_state == 'delivered' || s.current_state == 'unscheduled'}
  end
end


p = Project.new
p p.stories.size
p p.stories(epic: 'nes').size
p p.stories(epic: 'enes').size
byebug;1



