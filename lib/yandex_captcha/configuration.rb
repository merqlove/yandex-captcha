module YandexCaptcha
  # This class enables detailed configuration of the Yandex CleanWeb services.
  #
  # By calling
  #
  #   YandexCaptcha.configuration # => instance of YandexCaptcha::Configuration
  #
  # or
  #   YandexCaptcha.configure do |config|
  #     config # => instance of YandexCaptcha::Configuration
  #   end
  #
  # you are able to perform configuration updates.
  #
  # Your are able to customize all attributes listed below. All values have
  # sensitive default and will very likely not need to be changed.
  #
  # Please note that the public and private key for the Yandex CleanWeb API Access
  # have no useful default value. The keys may be set via the Shell enviroment
  # or using this configuration. Settings within this configuration always take
  # precedence.
  #
  # Setting the keys with this Configuration
  #
  #   YandexCaptcha.configure do |config|
  #     config.api_key  = 'cw.1.1.gsdjdgskjhsdgjkgsdjsdjgkskhsgjkgsjhdkgsdghskd.sdgjhgsdsgdkjgdshkgds'
  #     config.captcha_type  = 'elite'
  #     config.api_server_url = 'http://cleanweb-api.yandex.ru/1.0'
  #     config.skip_verify_env = ["test", "cucumber"]
  #     config.handle_timeouts_gracefull = true'
  #     config.current_env = "test"
  #   end
  #
  class Configuration
    attr_accessor :api_server_url,
                  :api_key,
                  :skip_verify_env,
                  :handle_timeouts_gracefully,
                  :captcha_type,
                  :current_env

    def initialize #:nodoc:
      @api_server_url             = API_URL
      @captcha_type               = CAPTCHA_TYPE
      @api_key                    = ENV['CAPTCHA_KEY']
      @skip_verify_env            = SKIP_VERIFY_ENV
      @handle_timeouts_gracefully = HANDLE_TIMEOUTS_GRACEFULLY
      @current_env                = ENV['RACK_ENV'] || ENV['RAILS_ENV']
    end

  end
end
