require 'json'
require 'yaml'
require 'rest-client'

class SlackNotifier
  IMAGES = YAML.load_file('images.yml')

  attr_reader :name, :pull_request

  def initialize(pull_request)
    @pull_request = pull_request
    @name = ENV['SLACK_NAMES'].split(',').sample
  end

  def notify
    RestClient.post(ENV['SLACK_ENDPOINT'], {
      payload: payload.to_json
    }, {
      content_type: :json,
      accept: :json
    })
  end

  def payload
    {
      icon_url: IMAGES.sample,
      username: 'Github PR Assignment',
      attachments: [{
        fallback: "#{name}, review #{link}",
        pretext: name,
        title: pull_request['title'],
        title_link: link
      }]
    }
  end

  private

  def link
    pull_request['html_url']
  end
end
