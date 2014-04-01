YandexCleanweb::Engine.routes.draw do
  match 'captcha' => 'captcha#show'
end