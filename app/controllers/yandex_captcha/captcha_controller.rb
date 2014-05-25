module YandexCaptcha
  class CaptchaController < YandexCaptcha::ApplicationController
    respond_to :json
    def show
      respond_with YandexCaptcha::Verify.get_captcha
    end
  end
end