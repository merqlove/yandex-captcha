# encoding: utf-8
require "test_helper"

describe YandexCaptcha do

  context "without api key" do
    before do
      YandexCaptcha.configure do |config|
        config.api_key  = nil
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
          YandexCaptcha::Verify.valid_captcha?("anything", "anything", 123)
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
      end
    end

    describe "#spam?" do

      describe "simple check" do
        it "works" do
          YandexCaptcha::Verify.spam?("фраза").must_equal false
          YandexCaptcha::Verify.spam?("недорого увеличение пениса проститутки").must_equal false
        end
      end

      describe "advanced mode" do
        it "works" do
          YandexCaptcha::Verify.spam?(body_plain: "my text", ip: "80.80.40.3").must_equal false
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

        valid = YandexCaptcha::Verify.valid_captcha?(result[:id], captcha[:captcha], "1234")
        valid.must_equal false
      end
    end

    describe "raises BadResponseException in case of empty result" do
      before do
        FakeWeb.clean_registry
      end

      it "check for spam" do
        FakeWeb.register_uri(:post, "http://cleanweb-api.yandex.ru/1.0/check-spam", body: "")
        proc { YandexCaptcha::Verify.spam?(body_plain: "any text") }.must_raise(YandexCaptcha::BadResponseException)
      end
    end
  end
end
