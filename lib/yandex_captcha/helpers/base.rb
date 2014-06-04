module YandexCaptcha
  module Helpers
    module Base
      def valid_captcha?(*args)
        YandexCaptcha::Verify.valid_captcha? *args
      end
    end
  end
end