require "yandex_cleanweb"
module YandexCleanweb

  class Engine < Rails::Engine
    isolate_namespace YandexCleanweb
    engine_name 'yandex_cleanweb'
    config.mount_at = '/'

    if Rails.version >= '3.1'
      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( yandex_cleanweb/captcha.js yandex_cleanweb/captcha.css yandex_cleanweb/loading.gif )
      end
    end

    # Check the gem config
    initializer "check config" do |app|
      # make sure mount_at ends with trailing slash
      config.mount_at += '/'  unless config.mount_at.last == '/'
    end

    initializer "setup config" do
      begin
        ActionView::Base.send(:include, ::YandexCleanweb::ClientHelper)
        ActionController::Base.send(:include, ::YandexCleanweb::Verify)
      end
    end

  end

end