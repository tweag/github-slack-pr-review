require 'spec_helper'
require_relative '../app'

if ENV['SLACK_ENDPOINT']
  class IntegrationSpec < Minitest::Spec
    include GithubHelpers
    include Rack::Test::Methods

    let(:app) { App.new }

    it 'sends a slack notification without error' do
      post '/', request_body.to_json, 'Content-Type' => 'application/json'
      last_response.must_be :ok?
    end
  end
else
  puts "Export ENV['SLACK_ENDPOINT'] to run the integration spec"
end
