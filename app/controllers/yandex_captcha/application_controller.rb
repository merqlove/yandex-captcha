module YandexCaptcha
  class ApplicationController < ::ApplicationController
    layout false
    before_filter :setup
    _process_action_callbacks.map(&:filter)
  end
end