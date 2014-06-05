ENV["RAILS_ENV"] = "test"

require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"
require "minitest-spec-context"
require 'webmock/minitest'

require "yandex_captcha"

WebMock.allow_net_connect!