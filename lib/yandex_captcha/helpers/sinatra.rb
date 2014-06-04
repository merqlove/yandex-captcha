module YandexCaptcha
  module Helpers
    module Sinatra
      include Base
      def captcha_tags(options = {})
        template = settings.captcha_ajax_template.to_s.to_sym
        if options[:ajax]
          render(current_engine, template, {layout: false}).to_s.html_safe
        else
          captcha = YandexCaptcha::Verify.get_captcha
          render(current_engine, template, {layout: false}, { captcha: captcha, noscript: options[:noscript] }).to_s.html_safe if captcha
        end
      end

    end
  end
end
