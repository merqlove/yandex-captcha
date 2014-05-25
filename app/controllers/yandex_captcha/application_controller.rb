module YandexCaptcha
  class ApplicationController < ActionController::Base
    layout false
    protect_from_forgery
  end
end