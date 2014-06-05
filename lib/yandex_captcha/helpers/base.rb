module YandexCaptcha
  module Helpers
    module Base

      def self.included(base)
        base.send :include, InstanceMethods
      end

      module InstanceMethods
        def spam? *args
          YandexCaptcha::Verify.spam? *args
        end

        def get_captcha *args
          YandexCaptcha::Verify.get_captcha *args
        end

        def valid_captcha? *args
          YandexCaptcha::Verify.valid_captcha? *args
        end
      end

    end
  end
end