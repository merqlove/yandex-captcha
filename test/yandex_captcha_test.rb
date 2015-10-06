# encoding: utf-8
require "test_helper"

describe YandexCaptcha do
  context "with test environment" do
    before do
      YandexCaptcha.configure do |config|
        config.current_env = "test"
      end
    end

    describe "#skip_env" do
      it "skipping" do
        YandexCaptcha.skip_env.must_equal true
      end
    end
  end

  context "with dev environment" do
    before do
      YandexCaptcha.configure do |config|
        config.current_env = "development"
      end
    end

    describe "#skip_env" do
      it "working" do
        YandexCaptcha.skip_env.must_equal false
      end
    end
  end

  context "without api key" do
    before do
      YandexCaptcha.configure do |config|
        config.api_key = nil
        config.current_env = "development"
      end
    end

    describe "#spam?" do
      it "raise an error" do
        -> {
          YandexCaptcha::Verify.spam?("anything")
        }.must_raise YandexCaptcha::NoApiKeyException
      end
    end

    describe "#get_captcha" do
      it "raise an error" do
        -> {
          YandexCaptcha::Verify.get_captcha("anything")
        }.must_raise YandexCaptcha::NoApiKeyException
      end
    end

    describe "#valid_captcha?" do
      it "raise an error" do
        -> {
          YandexCaptcha::Verify.valid_captcha?("anything", 123, "anything")
        }.must_raise YandexCaptcha::NoApiKeyException
      end
    end

  end

  context "with empty api key" do
    before do
      YandexCaptcha.configure do |config|
        config.api_key = ""
      end
    end

    it "raise an error" do
      -> {
        YandexCaptcha::Verify.spam?("anything")
      }.must_raise YandexCaptcha::NoApiKeyException
    end
  end

  context "with api key" do

    before do
      YandexCaptcha.configure do |config|
        config.api_key = "cw.1.1.20121227T080449Z.51de1ee126e5ced6.f4f417fb55727520d7e39b00cf5393d4b1ca5e78"
        config.current_env = "development"
      end
    end

    describe "#spam?" do

      describe "simple check" do
        it "works simple" do
          YandexCaptcha::Verify.spam?("фраза").must_equal false
          YandexCaptcha::Verify.spam?("недорого увеличение пениса проститутки").must_equal false
        end
      end

      describe "advanced mode" do
        it "works advanced" do
          ipv4 = IPAddr.new(rand(2**32),Socket::AF_INET)
          YandexCaptcha::Verify.spam?(body_plain: "my text", ip: ipv4).must_equal false
        end

        it "with some html" do
          result = YandexCaptcha::Verify.spam?(body_html: "some spam <a href='http://spam.com'>spam link</a>")

          result[:id].wont_be_empty
          result[:links].must_be_empty
        end
      end
    end

    describe "#get_captcha + #valid_captcha?" do

      it "works for not valid captchas" do
        result = YandexCaptcha::Verify.spam?(body_html: "some spam <a href='http://spam.com'>spam link</a>")
        captcha = YandexCaptcha::Verify.get_captcha(result[:id])

        captcha[:url].wont_be_empty
        captcha[:captcha].wont_be_empty

        valid = YandexCaptcha::Verify.valid_captcha?(captcha[:captcha], "1234", result[:id])
        valid.must_equal false
      end
    end

    describe "raises BadResponseException in case of empty result" do
      before do
        WebMock.disable_net_connect!
      end

      it "check for spam" do
        stub_request(:post, "http://cleanweb-api.yandex.ru/1.0/check-spam")
        proc { YandexCaptcha::Verify.spam?(body_plain: "any text") }.must_raise(YandexCaptcha::BadResponseException)
        WebMock.reset!
        WebMock.allow_net_connect!
      end
    end
  end
end
