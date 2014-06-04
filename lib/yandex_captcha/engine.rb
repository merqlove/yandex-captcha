module YandexCaptcha
  class Engine < Rails::Engine
    isolate_namespace YandexCaptcha
    engine_name 'yandex_captcha'

    if Rails.version >= '3.1'
      initializer :assets do |app|
        app.config.assets.precompile += %w( yandex_captcha/captcha.js yandex_captcha/captcha.css yandex_captcha/loading.gif )
      end
    end

    initializer "setup config" do
      begin
        ActionView::Base.send(:include, ::YandexCaptcha::Helpers::Rails)
        ActionController::Base.send(:include, ::YandexCaptcha::Verify)
        ActionController::Base.send(:include, ::YandexCaptcha::Helpers::Base)
      end
    end
  end
end
