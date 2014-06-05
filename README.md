# Yandex Captcha

[![Code Climate](https://codeclimate.com/github/merqlove/yandex-captcha.png)](https://codeclimate.com/github/merqlove/yandex-captcha)
[![Build Status](https://travis-ci.org/merqlove/yandex-captcha.svg)](https://travis-ci.org/merqlove/yandex-captcha)
[![Inline docs](http://inch-ci.org/github/merqlove/yandex-captcha.svg)](http://inch-ci.org/github/merqlove/yandex-captcha)

Ruby wrapper for [Yandex Cleanweb](http://api.yandex.ru/cleanweb/) spam detector.

Unfortunatelly, this gem *is not capable with MRI 1.8.7* because of MRI 1.8.7 doesn't have `URI.encode_www_form` method.

## Installation

Add this line to your application's Gemfile:

    gem 'yandex_captcha', '~> 0.4.3'

Or:    

    gem 'yandex_captcha', github: 'merqlove/yandex-captcha'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex_captcha

This gem can be used as Rails Engine or Sinatra Extension.

Tested:
- Rails 3.2+ (Rails 4 also checked)
- Sinatra 1.4+

## Usage

Get the api key: [http://api.yandex.ru/cleanweb/getkey.xml](http://api.yandex.ru/cleanweb/getkey.xml)

### Code

```ruby
# Rails routes
mount YandexCaptcha::Engine, at: '/yandex_captcha/'

# Sinatra
register YandexCaptcha::Sinatra

# Configuration
YandexCaptcha.configure do |config|
  config.api_key = "your_key"
end
```

### In Views

#### View Helper Options

- `ajax` = `true/false`
- `noscript` = `true/false` Only for non ajax version.

#### Code

```erb
<form action="/path" method="POST">
  <%= captcha_tags ajax:true %>
  <input type="submit" value="Submit" />
</form>

or

<%= form_tag some_response_path do %>
  <%= captcha_tags ajax:true %>
  <%= submit_tag 'Submit' %>
<% end %>
```

### In Controllers

```ruby
# Rails / Sinatra / or if you included helpers
if valid_captcha?(params[:captcha_response_id], params[:captcha_response_field])
  # some
end

# Long way
if YandexCaptcha::Verify.valid_captcha?(params[:captcha_response_id], params[:captcha_response_field])
  # some
end
```

### Other examples

```ruby
# Helpers
spam?("just phrase")
  => false

# Methods
YandexCaptcha::Verify.spam?("just phrase")
  => false

YandexCaptcha::Verify.spam?(body_plain: "my text", ip: "80.80.40.3")
  => false

YandexCaptcha::Verify.spam?(body_html: "some spam <a href='http://spam.com'>spam link</a>")
  => { id: "request id", links: [ ['http://spam.com', true] ] }
```

### More complex example

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

---

Special respect to Evrone which gem `yandex-cleanweb` include most of code in `lib/yandex_captcha/verify.rb` and some examples on this page.