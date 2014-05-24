# encoding: UTF-8
module YandexCleanweb
  module ClientHelper
    # Your public API can be specified in the +options+ hash or preferably
    # using the Configuration.
    def captcha_tags(options = {})
      # Default options
      error = options[:error] ||= ((defined? flash) ? flash[:captcha_error] : "")
      if options[:ajax]
        render "yandex_cleanweb/captcha_ajax_tags"
      else
        captcha = YandexCleanweb::Verify.get_captcha
        render "yandex_cleanweb/captcha_tags", :locals => { :captcha => captcha, error: error } if captcha
      end
    end # captcha_tags

  end # ClientHelper
end # YandexCleanweb
