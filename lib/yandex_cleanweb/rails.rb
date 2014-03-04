require "yandex_cleanweb"

ActionView::Base.send(:include, YandexCleanweb::ClientHelper)
ActionController::Base.send(:include, YandexCleanweb::Verify)