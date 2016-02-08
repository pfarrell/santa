$: << File.expand_path('../app', __FILE__)

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/respond_to'
require 'sinatra/cookies'
require 'securerandom'
require 'haml'
require 'tracker_api'
require 'byebug'
require 'rufus-scheduler'

class App < Sinatra::Application
  helpers Sinatra::UrlForHelper
  helpers Sinatra::Cookies
  register Sinatra::RespondTo

  enable :sessions
  set :session_secret, ENV["APP_SESSION_SECRET"] || "youshouldreallychangethis"
  set :views, Proc.new { File.join(root, "app/views") }

  before do
    response.set_cookie(:appc, value: SecureRandom.uuid, expires: Time.now + 3600 * 24 * 365 * 10) if request.cookies["bmc"].nil?
    @breadcrumbs = [] if @breakcrumbs.nil?
  end

  def self.update_tracker
    puts 'refreshing started'
    client=TrackerApi::Client.new(token: ENV['PIVOTAL_TOKEN'])
    @@project = client.project(ENV['PIVOTAL_PROJECT_ID'])
    @@stories = @@project.stories
    @@epics ||= {}
    puts 'refreshing complete'
  end
end

scheduler = Rufus::Scheduler.new
scheduler.in '1m' do
  App.update_tracker
end
#scheduler.join

App.update_tracker
require 'models'
require 'routes'
