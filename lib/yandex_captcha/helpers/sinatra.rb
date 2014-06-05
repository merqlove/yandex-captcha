module YandexCaptcha
  module Helpers
    module Sinatra
      def captcha_tags(options = {})
        return if YandexCaptcha.skip_env

        template = settings.captcha_ajax_template.to_s.to_sym
        if options[:ajax]
          render(current_engine, template, {layout: false}).to_s.html_safe
        else
          error = options[:error] ||= ((defined? flash) ? flash[:yandex_captcha_error] : "")
          captcha = YandexCaptcha::Verify.get_captcha
          render(current_engine, template, {layout: false}, { captcha: captcha, error: error, noscript: options[:noscript] }).to_s.html_safe if captcha
        end
      end

    end
  end
end
