# encoding: UTF-8
module YandexCleanweb
  module ClientHelper
    # Your public API can be specified in the +options+ hash or preferably
    # using the Configuration.
    def captcha_tags(options = {})
      # Default options
      error = options[:error] ||= ((defined? flash) ? flash[:captcha_error] : "")
      captcha = YandexCleanweb::Verify.get_captcha
      html  = ""
      if options[:ajax]
        html << <<-EOS
          <div id="captcha_widget">
          <div id="captcha_image" style="display:none;">
             <img src="" />
          </div>
          <input type="text" id="captcha_response_field" name="captcha_response_field" placeholder="Введите цифры" />
          <input type="hidden" name="captcha_response_id" value="" />
          </div>
          #{javascript_include_tag "yandex_cleanweb/captcha"}
        EOS
      else
        html << %{#{error ? "&amp;error=#{CGI::escape(error)}" : ""}}
        unless options[:noscript] == false
          #html << %{<noscript>\n  }
          html << %{<div id="captcha_widget">\n }
          html << %{<div id="captcha_image">\n }
          html << %{<img src="#{captcha[:url]}" />\n }
          html << %{</div>\n }
          html << %{<input type="text" id="captcha_response_field" name="captcha_response_field" placeholder="Введите цифры" />\n }
          html << %{<input type="hidden" name="captcha_response_id" value="#{captcha[:captcha]}" />\n }
          html << %{</div>\n }
          #html << %{</noscript>\n}
        end
      end
      return (html.respond_to?(:html_safe) && html.html_safe) || html
    end # captcha_tags

  end # ClientHelper
end # YandexCleanweb