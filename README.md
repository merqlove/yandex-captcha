# Yandex Captcha

[![Code Climate](https://codeclimate.com/github/merqlove/yandex-captcha.png)](https://codeclimate.com/github/merqlove/yandex-captcha)
[![Build Status](https://travis-ci.org/merqlove/yandex-captcha.svg)](https://travis-ci.org/merqlove/yandex-captcha)

Ruby wrapper for [Yandex Cleanweb](http://api.yandex.ru/cleanweb/) spam detector.

Unfortunatelly, this gem *is not capable with MRI 1.8.7* because of MRI 1.8.7 doesn't have `URI.encode_www_form` method.

## Installation

Add this line to your application's Gemfile:

    gem 'yandex_captcha', '~> 0.0.5'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex_captcha

## Usage

Get the api key: [http://api.yandex.ru/cleanweb/getkey.xml](http://api.yandex.ru/cleanweb/getkey.xml)

```ruby
# Rails routes
mount YandexCaptcha::Engine, :at => '/yandex_captcha/'

#Sinatra
register YandexCaptcha::Sinatra

# Configuration
YandexCaptcha.configure do |config|
  config.api_key = "your_key"
end

#Methods
YandexCaptcha::Verify.spam?("just phrase")
  => false

YandexCaptcha::Verify.spam?(body_plain: "my text", ip: "80.80.40.3")
  => false

YandexCaptcha::Verify.spam?(body_html: "some spam <a href='http://spam.com'>spam link</a>")
  => { id: "request id", links: [ ['http://spam.com', true] ] }
```

More complex example:

```ruby

user_input = "download free porn <a>...</a>"
if spam_check = YandexCaptcha::Verify.spam?(user_input, ip: current_user.ip)
  captcha = YandexCaptcha::Verify.get_captcha(spam_check[:id])

  # now you can show captcha[:url] to user
  # but remember to write captcha[:captcha] to session

  # to check is captcha enterred by user is valid:
  captcha_valid = YandexCaptcha::Verify.valid_captcha?(result[:id], captcha[:captcha], user_captcha)
end
```

If you use Yandex Captcha in Rails app, we recommend to set up the api key in `config/initializers/yandex_captcha.rb`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Much thanks to Evrone for `Verify` base.