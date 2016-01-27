require 'spec_helper'
require 'slack_notifier'

class SlackNotifierTest < Minitest::Spec
  include GithubHelpers

  let(:slack) {
    SlackNotifier.new(pull_request)
  }

  describe '#next_name' do
    it 'does a round-robin' do
      SlackNotifier.index = nil
      SlackNotifier.stubs(:names).returns(['a', 'b', 'c'])
      assigned = Array.new(4) { SlackNotifier.next_name }
      assigned.must_equal ['a', 'b', 'c', 'a']
    end
  end

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
      payload[:username].must_equal 'Github PR Assignment'
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
