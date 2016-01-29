require 'tracker_api'
require 'byebug'

module Tracker
  def initialize
    @client=TrackerApi::Client.new(token: ENV['PIVOTAL_TOKEN'])
  end
end

class Project
  include Tracker
  attr_accessor :client, :stories

  def stories(opts={})
    @stories ||= client.projects.first.stories.select{|s| (['nes','enes'] & s.labels.map(&:name)).size > 0}
    opts[:epic].nil? ? @stories : @stories.select{|s| s.labels.select{|l| l.name.downcase == "#{opts[:epic].downcase}"}.size > 0}
    #@stories
  end

  def active(opts={})
    stories(opts).reject{|s| ([s.current_state] & ['accepted','unscheduled']).size > 0}
  end
end

class Owner
  include Tracker
  attr_accessor :client, :owners

end

p = Project.new
p p.stories.size
p p.stories(epic: 'nes').size
p p.stories(epic: 'enes').size
p p.active(epic: 'enes').size
byebug;1



