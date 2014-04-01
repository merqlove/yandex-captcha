module YandexCleanweb
  class CaptchaController < YandexCleanweb::ApplicationController
    respond_to :html, :json
    def show
      respond_with(YandexCleanweb::Verify.get_captcha)
    end
  end
end