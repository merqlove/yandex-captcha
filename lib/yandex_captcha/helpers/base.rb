module YandexCaptcha
  module Helpers
    module Base
      def valid_captcha?(options = {})
        YandexCaptcha::Verify.valid_captcha? options
      end
    end
  end
end