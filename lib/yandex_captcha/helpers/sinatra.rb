module YandexCaptcha
  module Helpers
    module Sinatra

      def captcha_tags(options = {})
        if options[:ajax]
          render :erb, settings.captcha_ajax_template.to_s.to_sym, {layout: false}
        else
          captcha = YandexCaptcha::Verify.get_captcha
          render :erb, settings.captcha_template.to_s.to_sym, {layout: false}, { captcha: captcha, noscript: options[:noscript] } if captcha
        end
      end

    end
  end
end