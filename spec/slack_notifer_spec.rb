require 'spec_helper'
require 'slack_notifier'

class SlackNotifierTest < Minitest::Spec
  include GithubHelpers

  let(:slack) {
    SlackNotifier.new(pull_request)
  }

  describe '#payload' do
    let(:payload) {
      slack.payload
    }

    let(:attachment) {
      payload[:attachments].first
    }

    it 'has an icon' do
      payload[:icon_url].wont_be :nil?
    end

    it 'has a username' do
      payload[:username].must_equal 'GitHub PR Assignment'
    end

    it 'has an attachment fallback that notifies a specific user' do
      attachment[:fallback].must_include slack.name
    end

    it 'has an attachment fallback that provides a link' do
      attachment[:fallback].must_include pull_request['html_url']
    end

    it 'has an attachment pretext that notifies a specific user' do
      attachment[:pretext].must_include slack.name
    end
  end
end
