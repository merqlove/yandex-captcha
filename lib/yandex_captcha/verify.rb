require "uri"
require "nokogiri"
require "net/http"

module YandexCaptcha
  module Verify
    class << self

      def spam?(*options)
        response = api_check_spam(options)
        doc = Nokogiri::XML(response)

        spam_result = doc.xpath('//check-spam-result')
        request_id_tag = spam_result.xpath('id')
        spam_flag_tag = spam_result.xpath('text')

        raise BadResponseException if request_id_tag.size.zero?

        request_id = request_id_tag.first
        spam_flag = spam_flag_tag.first.attributes["spam-flag"]

        spam_check request_id.content, spam_result, spam_flag.content
      end

      def get_captcha(request_id=nil)
        response = api_get_captcha(request_id)
        doc = Nokogiri::XML(response)

        url = doc.xpath('//get-captcha-result/url').text
        captcha_id = doc.xpath('//get-captcha-result/captcha').text

        { url: url, captcha: captcha_id }
      end

      def valid_captcha?(captcha_id=nil, value=nil, request_id=nil)
        response = api_check_captcha(request_id, captcha_id, value)
        doc = Nokogiri::XML(response)
        doc.xpath('//check-captcha-result/ok').any?
      end

      private

      def api_check_captcha(request_id, captcha_id, value)
        check_captcha_url = "#{API_URL}/check-captcha"
        params = {
            key: prepare_api_key,
            id: request_id,
            captcha: captcha_id,
            value: value
        }

        uri = URI.parse(check_captcha_url)
        uri.query = URI.encode_www_form(params)

        Net::HTTP.get(uri)
      end

      def api_get_captcha(request_id)
        get_captcha_url = "#{API_URL}/get-captcha"
        params = { key: prepare_api_key, id: request_id, type: YandexCaptcha.configuration.captcha_type }

        uri = URI.parse(get_captcha_url)
        uri.query = URI.encode_www_form(params)

        Net::HTTP.get(uri)
      end

      def api_check_spam(options)
        cleanweb_options = { key: prepare_api_key }
        run_options = options[0]

        if run_options.is_a?(String) # quick check
          cleanweb_options[:body_plain] = run_options
        else
          options = run_options
          cleanweb_options.merge!(Hash[options.map{ |k,v| [k.to_s.gsub("_","-"), v] }])
        end

        check_spam_url = "#{API_URL}/check-spam"
        uri = URI.parse(check_spam_url)
        response = Net::HTTP.post_form(uri, cleanweb_options)
        response.body
      end

      def spam_check(request_id, spam_result, spam_flag)
        return false unless request_id or spam_result or spam_flag

        if spam_flag == 'yes'
          links = spam_result.xpath('links')
          links_childrens = links.first.children

          links_childrens.map do |el|
            [el.attributes["url"], el.attributes["spam_flag"] == 'yes']
          end

          { id: request_id, links: links_childrens }
        else
          false
        end
      end

      def prepare_api_key
        raise NoApiKeyException if YandexCaptcha.configuration.api_key.nil? || YandexCaptcha.configuration.api_key.empty?

        YandexCaptcha.configuration.api_key
      end
    end
  end
end
