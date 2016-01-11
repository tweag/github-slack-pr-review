require 'json'
require 'rest-client'
require 'sinatra/base'

class Slack < Struct.new(:url)
  def notify
    RestClient.post(endpoint, {
      payload: JSON.generate(text: message)
    }, {
      content_type: :json,
      accept: :json
    })
  end

  private

  def endpoint
    ENV['SLACK_ENDPOINT']
  end

  def names
    ENV['SLACK_NAMES'].split(',')
  end

  def message
    "#{names.sample}, please review this PR: #{url}"
  end
end

class App < Sinatra::Base
  get '/' do
    status 200
  end

  post '/' do
    pr = JSON.parse(request.body.read)

    if pr['action'] == 'opened'
      Slack.new(pr['pull_request']['url']).notify
    end

    status 200
  end
end
