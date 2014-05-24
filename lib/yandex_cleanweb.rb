require 'yandex_cleanweb/configuration'
require 'yandex_cleanweb/verify'

module YandexCleanweb
  class NoApiKeyException < Exception; end
  class BadResponseException < Exception; end

  API_URL = 'http://cleanweb-api.yandex.ru/1.0'
  CAPTCHA_TYPE = 'std'
  HANDLE_TIMEOUTS_GRACEFULLY      = true
  SKIP_VERIFY_ENV = ['test', 'cucumber']

  # Gives access to the current Configuration.
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Allows easy setting of multiple configuration options. See Configuration
  # for all available options.
  #--
  # The temp assignment is only used to get a nicer rdoc. Feel free to remove
  # this hack.
  #++
  def self.configure
    config = configuration
    yield(config)
  end

  def self.with_configuration(config)
    original_config = {}

    config.each do |key, value|
      original_config[key] = configuration.send(key)
      configuration.send("#{key}=", value)
    end

    result = yield if block_given?

    original_config.each { |key, value| configuration.send("#{key}=", value) }
    result
  end

  class YandexCleanwebError < StandardError
  end
end

if defined?(Rails)
  require 'yandex_cleanweb/rails'
end

if defined?(Sinatra) and Sinatra.respond_to? :register
  require 'yandex_cleanweb/sinatra'
end
