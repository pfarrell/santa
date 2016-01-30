module Tracker
  def initialize
    @client=TrackerApi::Client.new(token: ENV['PIVOTAL_TOKEN'])
  end
end
