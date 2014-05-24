require 'sinatra/base'
require 'helpers/sinatra'

module YandexCleanweb
  module Sinatra
    def self.registered(app)
      app.set :captcha_ajax_template, "yandex_cleanweb/captcha_ajax"
      app.set :captcha_template, "yandex_cleanweb/captcha"
      app.set :captcha_url, "/get_captcha"

      app.get app.settings.captcha_url do
        content_type :json
        YandexCleanweb::Verify.get_captcha.to_json
      end

      app.helpers Helpers::Sinatra
    end
  end
end
