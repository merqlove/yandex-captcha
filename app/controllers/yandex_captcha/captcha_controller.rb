module YandexCaptcha
  class CaptchaController < YandexCaptcha::ApplicationController
    respond_to :json
    def show
      respond_with get_captcha
    end
  end
end