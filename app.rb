require 'json'
require 'sinatra/base'
require 'slack_notifier'

class App < Sinatra::Base
  get '/' do
    status 200
  end

  post '/' do
    event = JSON.parse(request.body.read)

    if event['action'] == 'opened'
      SlackNotifier.new(event['pull_request']).notify
    end

    status 200
  end
end
