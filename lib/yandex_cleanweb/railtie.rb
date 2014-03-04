require "yandex_cleanweb"
module Rails
  module YandexCleanweb
    class Railtie < Rails::Railtie
      initializer "setup config" do
        begin
          ActionView::Base.send(:include, ::YandexCleanweb::ClientHelper)
          ActionController::Base.send(:include, ::YandexCleanweb::Verify)
        end
      end
    end
  end
end