require "shouqianba/webapi/version"
require "open-uri"

module Shouqianba
  module Webapi
    class Error < ::StandardError
      attr_accessor :result_code, :error_message, :data

      def initialize(result_code, error_message, data)
        @result_code = result_code.to_i
        @error_message = error_message
        @data = data
        message = "[ result_code: #{@result_code}, error_message: #{@error_message} ]"
        super(message)
      end
    end

    ShouqianbaHost = "https://api.shouqianba.com"
    #you code goes here
    def self.activate(vendor_sn, vendor_key, app_id, code, device_id, options={})
      params = {
        app_id: app_id,
        code:   code,
        device_id: device_id
      }.merge({
        name: options[:name],
        os_info: options[:os_info],
        sdk_version: options[:sdk_version]
        })

      self.post_method "/terminal/activate", vendor_sn, vendor_key, {}, params do |resp|
        yield(resp)
      end
    end

    def self.checkin(terminal_sn, terminal_key, device_id, options={})
      params = {
        terminal_sn: terminal_sn,
        device_id: device_id
        }.merge({
          os_info: options[:os_info],
          sdk_version: options[:sdk_version]
        })
      self.post_method "/terminal/checkin", terminal_sn, terminal_key, {}, params do |resp|
        yield(resp)
      end
    end

    def self.pay(terminal_sn, terminal_key, client_sn, total_amount, dynamic_id, subject, operator, options={})
      params = {
        terminal_sn: terminal_sn,
        client_sn: client_sn,
        total_amount: total_amount,
        dynamic_id: dynamic_id,
        subject: subject,
        operator: operator,
        }.merge({
          payway: options[:payway],
          description: options[:description],
          longitude: options[:longitude],
          latitude: options[:latitude],
          device_id: options[:device_id],
          extended: options[:extended],
          reflect: options[:reflect],
          notify_url: options[:notify_url]
        })
      self.post_method "/upay/v2/pay", terminal_sn, terminal_key, {}, params do |resp|
        yield(resp)
      end
    end


    def self.precreate(terminal_sn, terminal_key, client_sn, total_amount, payway, subject, operator, options={})
      params = {
        terminal_sn: terminal_sn,
        client_sn: client_sn,
        total_amount: total_amount,
        payway: payway,
        subject: subject,
        operator: operator
        }.merge({
          sub_payway: options[:sub_payway],
          payer_uid: options[:payer_uid],
          description: options[:description],
          longitude: options[:longitude],
          latitude: options[:latitude],
          extended: options[:extended],
          reflect: options[:reflect],
          notify_url: options[:notify_url]
        })
      self.post_method "/upay/v2/precreate", terminal_sn, terminal_key, {}, params do |resp|
        yield(resp)
      end
    end

    def self.refund(terminal_sn, terminal_key, refund_request_no, operator, refund_amount, options={})
      params = {
        terminal_sn: terminal_sn,
        refund_request_no: refund_request_no,
        operator: operator,
        refund_amount: refund_amount
        }.merge({
          sn: options[:sn],
          client_sn: options[:client_sn],
          client_tsn: options[:client_tsn],

        })
      self.post_method "/upay/v2/refund", terminal_sn, terminal_key, {}, params do |resp|
        yield(resp)
      end
    end

    def self.cancel(terminal_sn, terminal_key, options={})
      params = {
        terminal_sn: terminal_sn
        }.merge({
          sn: options[:sn],
          client_sn: options[:client_sn]
        })
      self.post_method "/upay/v2/cancel", terminal_sn, terminal_key, {}, params do |resp|
        yield(resp)
      end
    end

    def self.query(terminal_sn, terminal_key, options={})
      params = {
        terminal_sn: terminal_sn
      }.merge({
        sn: options[:sn],
        client_sn: options[:client_sn]
      })
      self.post_method "/upay/v2/query", terminal_sn, terminal_key, {}, params do |resp|
        yield(resp)
      end
    end

    def self.wap2_url(vendor_sn, vendor_key, terminal_sn, client_sn, total_amount, subject, operator, return_url, options={})
      params = {
        terminal_sn: terminal_sn,
        client_sn: client_sn,
        total_amount: total_amount,
        subject: subject,
        return_url: return_url
      }.merge({
        payway: options[:payway],
        description: options[:description],
        longitude: options[:longitude],
        latitude: options[:latitude],
        extended: options[:extended],
        reflect: options[:reflect],
        notify_url: options[:notify_url]
        })
      body = params.is_a?(String) ? params : JSON.generate(params)
      params[:sign] = get_sign(body, vendor_key)
      "https://m.wosai.cn/qr/gateway?#{params.to_query}"
    end


    def self.get_sign(body, vendor_or_terminal_key)
      Digest::MD5.hexdigest(body+ vendor_or_terminal_key)
    end

    # 如果body是字符串，则直接作为请求的内容。如果body是其他类型，则会在内部调用to_json
    def self.post_method(url, vendor_or_terminal_sn, vendor_or_terminal_key, params={}, body={})
      uri = URI.parse("#{ShouqianbaHost}#{url}?#{params.to_query}")
      https = Net::HTTP.new(uri.host,uri.port)
      https.open_timeout = 60
      https.read_timeout = 60
      https.use_ssl = true
      body = body.is_a?(String) ? body : JSON.generate(body)
      req = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'Authorization' => "#{vendor_or_terminal_sn} #{self.get_sign(body, vendor_or_terminal_key)}"})
      req.body = body
      response = https.request(req)
      data = ActiveSupport::JSON.decode(response.body).to_options
      check_errcode(data)
      yield(data[:biz_response])
    end

    def self.check_errcode(data)
      Rails.logger.info data
      if data[:result_code].present? && data[:result_code] != "200"
        raise Shouqianba::Webapi::Error.new(data[:result_code], data[:error_message], data)
      end
    end
  end
end
