require "yandex_cleanweb"
module YandexCleanweb

  class Engine < Rails::Engine
    isolate_namespace YandexCleanweb
    #engine_name 'yandex_cleanweb'
    #
    #config.autoload_paths += %W(#{config.root}/lib)
    #
    #config.after_initialize do
    #  Rails.application.routes_reloader.reload!
    #end

    initializer "setup config" do
      begin
        ActionView::Base.send(:include, ::YandexCleanweb::ClientHelper)
        ActionController::Base.send(:include, ::YandexCleanweb::Verify)
      end
    end

  end

end