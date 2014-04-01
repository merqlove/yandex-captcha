module YandexCleanweb
  class CaptchaController < YandexCleanweb::ApplicationController
    def show
      respond_to do |format|
        format.json { render :json => YandexCleanweb::Verify.get_captcha }
      end
    end
  end
end