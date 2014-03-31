require "yandex_cleanweb"
module YandexCleanweb

  class Engine < Rails::Engine

    initialize "setup config" do
      begin
        ActionView::Base.send(:include, ::YandexCleanweb::ClientHelper)
        ActionController::Base.send(:include, ::YandexCleanweb::Verify)
      end
    end

  end

end