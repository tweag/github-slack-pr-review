require 'bundler'
Bundler.require :default, :test

require 'minitest/spec'
require 'minitest/pride'
require 'minitest/autorun'
require 'mocha/mini_test'

ENV['SLACK_NAMES'] ||= '@ray,@ryan'

module GithubHelpers
  REQUEST_FIXTURE = File.expand_path('../fixtures/request.json', __FILE__)

  def request_body
    JSON.parse File.read(REQUEST_FIXTURE)
  end

  def pull_request
    request_body['pull_request']
  end
end
