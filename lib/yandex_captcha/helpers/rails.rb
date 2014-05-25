# encoding: UTF-8
module YandexCaptcha
  module Helpers
    module Rails
      # Your public API can be specified in the +options+ hash or preferably
      # using the Configuration.
      def captcha_tags(options = {})
        # Default options
        error = options[:error] ||= ((defined? flash) ? flash[:captcha_error] : "")
        if options[:ajax]
          render "yandex_captcha/captcha_ajax"
        else
          captcha = YandexCaptcha::Verify.get_captcha
          render "yandex_captcha/captcha", locals: { captcha: captcha, error: error, noscript: options[:noscript] } if captcha
        end
      end # captcha_tags

    end # Rails
  end
end # YandexCleanweb
