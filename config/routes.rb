YandexCaptcha::Engine.routes.draw do
  get 'captcha' => 'captcha#show'
end