module YandexCleanweb
  module Helpers
    module Sinatra
    # Your public API can be specified in the +options+ hash or preferably
    # using the Configuration.
    def captcha_tags(options = {})
      if options[:ajax]
        render :erb, settings.captcha_ajax_template.to_s.to_sym, {layout: false}
      else
        captcha = YandexCleanweb::Verify.get_captcha
        render :erb, settings.captcha_template.to_s.to_sym, {layout: false}, { captcha: captcha, noscript: options[:noscript] } if captcha
      end
    end # captcha_tags

    end
  end
end