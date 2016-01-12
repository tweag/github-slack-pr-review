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

  private

  def link
    pull_request['html_url']
  end

  def payload
    {
      icon_url: IMAGES.sample,
      username: 'Github PR Assignment',
      attachments: [{
        fallback: "#{name}, please review this PR: #{link}",
        pretext: "#{name}, please review this PR:",
        text: pull_request['body'],
        title: pull_request['title'],
        title_link: link,
        fields: [{
          title: 'Assignee',
          value: name,
          short: true
        }, {
          title: 'Author',
          value: pull_request['user']['login'],
          short: true
        }, {
          title: 'Additions',
          value: pull_request['additions'],
          short: true
        }, {
          title: 'Deletions',
          value: pull_request['deletions'],
          short: true
        }, {
          title: 'Commits',
          value: pull_request['commits'],
          short: true
        }, {
          title: 'Changed Files',
          value: pull_request['changed_files'],
          short: true
        }]
      }]
    }
  end
end
