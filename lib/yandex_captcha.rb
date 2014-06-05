require 'yandex_captcha/configuration'
require 'yandex_captcha/verify'
require 'yandex_captcha/helpers/base'

module YandexCaptcha
  class NoApiKeyException < Exception; end
  class BadResponseException < Exception; end
  class YandexCaptchaError < StandardError; end

  API_URL = 'http://cleanweb-api.yandex.ru/1.0'
  CAPTCHA_TYPE = 'std'
  HANDLE_TIMEOUTS_GRACEFULLY      = true
  SKIP_VERIFY_ENV = ['test', 'cucumber']

  # Allows easy setting of multiple configuration options. See Configuration
  # for all available options.
  def self.configure
    config = configuration
    yield(config)
  end

  # Gives access to the current Configuration.
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.skip_env
    if configuration.skip_verify_env.include? configuration.current_env
      true
    else
      false
    end
  end
end

if defined?(Rails)
  require 'yandex_captcha/rails'
end

if defined?(Sinatra) and Sinatra.respond_to? :register
  require 'yandex_captcha/sinatra'
end
