require 'sinatra/base'
require 'yandex_captcha/helpers/sinatra'

module YandexCaptcha
  module Sinatra
    def self.registered(app)
      app.set :captcha_ajax_template, "yandex_captcha/captcha_ajax" unless app.settings.captcha_ajax_template
      app.set :captcha_template, "yandex_captcha/captcha" unless app.settings.captcha_template
      app.set :captcha_url, "/get_captcha" unless app.settings.captcha_url

      app.get app.settings.captcha_url do
        content_type :json
        YandexCaptcha::Verify.get_captcha.to_json
      end

      app.helpers Helpers::Sinatra
      app.helpers Helpers::Base
    end
  end
end
