require "yandex_cleanweb"
module YandexCleanweb
  class Engine < Rails::Engine
    isolate_namespace YandexCleanweb
    engine_name 'yandex_cleanweb'

    if Rails.version >= '3.1'
      initializer :assets do |app|
        app.config.assets.precompile += %w( yandex_cleanweb/captcha.js yandex_cleanweb/captcha.css yandex_cleanweb/loading.gif )
      end
    end

    initializer "setup config" do
      begin
        ActionView::Base.send(:include, ::YandexCleanweb::ClientHelper)
        ActionController::Base.send(:include, ::YandexCleanweb::Verify)
      end
    end
  end
end
