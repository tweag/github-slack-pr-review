require 'spec_helper'
require_relative '../app'

unless ENV['SLACK_ENDPOINT']
  abort "Export ENV['SLACK_ENDPOINT'] and try again..."
end

class IntegrationSpec < Minitest::Spec
  include GithubHelpers
  include Rack::Test::Methods

  let(:app) { App.new }

  it 'sends a slack notification without error' do
    post '/', request_body.to_json, 'Content-Type' => 'application/json'
    last_response.must_be :ok?
  end
end
