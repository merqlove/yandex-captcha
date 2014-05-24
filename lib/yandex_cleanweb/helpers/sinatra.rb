module YandexCleanweb
  module Helpers
    module Sinatra
    # Your public API can be specified in the +options+ hash or preferably
    # using the Configuration.
    def captcha_tags(options = {})
      if options[:ajax]
        erb settings.captcha_ajax_template.to_s.to_sym
      else
        captcha = YandexCleanweb::Verify.get_captcha
        erb settings.captcha_template.to_s.to_sym, locals: { captcha: captcha, noscript: options[:noscript] } if captcha
      end
    end # captcha_tags

    end
  end
end