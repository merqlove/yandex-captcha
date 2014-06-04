module YandexCaptcha
  module Helpers
    module Rails

      def captcha_tags(options = {})

        error = options[:error] ||= ((defined? flash) ? flash[:captcha_error] : "")
        if options[:ajax]
          render partial: "yandex_captcha/captcha_ajax"
        else
          captcha = YandexCaptcha::Verify.get_captcha
          render partial: "yandex_captcha/captcha", locals: { captcha: captcha, error: error, noscript: options[:noscript] } if captcha
        end
      end

    end
  end
end
