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
        #html << <<-EOS
        #  <div id="dynamic_recaptcha"></div>
        #  <script type="text/javascript">
        #    var rc_script_tag = document.createElement('script'),
        #        rc_init_func = function(){Recaptcha.create("#{key}", document.getElementById("dynamic_recaptcha")#{',RecaptchaOptions' if options[:display]});}
        #    rc_script_tag.src = "#{uri}/js/recaptcha_ajax.js";
        #    rc_script_tag.type = 'text/javascript';
        #    rc_script_tag.onload = function(){rc_init_func.call();};
        #    rc_script_tag.onreadystatechange = function(){
        #      if (rc_script_tag.readyState == 'loaded' || rc_script_tag.readyState == 'complete') {rc_init_func.call();}
        #    };
        #    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(rc_script_tag);
        #  </script>
        #EOS
      else
        unless options[:noscript] == false
          html << %{<noscript>\n  }
          html << %{#{error ? "&amp;error=#{CGI::escape(error)}" : ""}}
          html << %{ <div id="captcha_widget">\n }
          html << %{ <div id="captcha_image">\n }
          html << %{ <img src="#{captcha.url}" />\n }
          html << %{ </div>\n }
          html << %{ <input type="text" id="captcha_response_field" name="captcha_response_field" placeholder="Введите цифры" />\n }
          html << %{ <input type="hidden" name="captcha_response_id" value="#{captcha.captcha}" />\n }
          html << %{ </div>\n }
          html << %{</noscript>\n}
        end
      end
      return (html.respond_to?(:html_safe) && html.html_safe) || html
    end # captcha_tags

  end # ClientHelper
end # YandexCleanweb