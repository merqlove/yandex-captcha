require "yandex_cleanweb"
module YandexCleanweb

  class Engine < Rails::Engine
    isolate_namespace YandexCleanweb
    engine_name 'yandex_cleanweb'

    initializer "setup config" do
      begin
        ActionView::Base.send(:include, ::YandexCleanweb::ClientHelper)
        ActionController::Base.send(:include, ::YandexCleanweb::Verify)
      end
    end

    initializer "yandex_cleanweb.assets.precompile" do |app|
      app.config.assets.precompile += %w(captcha.coffee)
    end

  end

end