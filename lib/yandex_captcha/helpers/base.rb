module YandexCaptcha
  module Helpers
    module Base
      def self.included(base)
        base.send(:include, ::YandexCaptcha::Verify::Helpers)
      end
    end
  end
end