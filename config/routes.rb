YandexCleanweb::Engine.routes.draw do
  resource :captcha, :only => [:show]
end