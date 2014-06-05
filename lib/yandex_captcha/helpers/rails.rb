module YandexCaptcha
  module Helpers
    module Rails
      def captcha_tags(options = {})
        return if YandexCaptcha.skip_env

        if options[:ajax]
          render partial: "yandex_captcha/captcha_ajax"
        else
          error = options[:error] ||= ((defined? flash) ? flash[:yandex_captcha_error] : "")
          captcha = YandexCaptcha::Verify.get_captcha
          render partial: "yandex_captcha/captcha", locals: { captcha: captcha, error: error, noscript: options[:noscript] } if captcha
        end
      end
    end
  end
end
