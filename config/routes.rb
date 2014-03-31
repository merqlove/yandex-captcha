Rails.application.routes.draw do
  match 'ycaptcha' => 'captcha#show'
end