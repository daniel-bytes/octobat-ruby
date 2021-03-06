module Octobat
  class Invoice < APIResource
    extend Octobat::APIOperations::List
    include Octobat::APIOperations::Create
    include Octobat::APIOperations::Update
    
    
    def self.pdf_export(params = {}, opts={})
      api_key, headers = Util.parse_opts(opts)
      api_key ||= @api_key
      opts[:api_key] = api_key

      instance = self.new(nil, opts)

      response, api_key = Octobat.request(:post, url + '/pdf_export', api_key, params)
      return true
    end
    
    def self.csv_export(params = {}, opts={})
      api_key, headers = Util.parse_opts(opts)
      api_key ||= @api_key
      opts[:api_key] = api_key

      instance = self.new(nil, opts)

      response, api_key = Octobat.request(:post, url + '/csv_export', api_key, params)
      return true
    end
    

    def send_by_email(email_data = {})
      response, api_key = Octobat.request(:post, send_url, @api_key, email_data)
      refresh_from(response, api_key)
    end

    def confirm(confirmation_data = {})
      response, api_key = Octobat.request(:patch, confirm_url, @api_key, confirmation_data)
      refresh_from(response, api_key)
    end

    def cancel
      response, api_key = Octobat.request(:patch, cancel_url, @api_key)
      refresh_from(response, api_key)
    end

    def cancel_and_replace
      response, api_key = Octobat.request(:patch, cancel_and_replace_url, @api_key)
      refresh_from(response, api_key)
    end

    def delete
      response, api_key = Octobat.request(:delete, url, @api_key)
      refresh_from(response, api_key)
    end

    def items(params = {})
      Item.list(params.merge({ :invoice => id }), @api_key)
    end

    def transactions(params = {})
      Transaction.list(params.merge(invoice: id), @api_key)
    end


    private

      def send_url
        url + '/send'
      end

      def confirm_url
        url + '/confirm'
      end

      def cancel_url
        url + '/cancel'
      end

      def cancel_and_replace_url
        url + '/cancel_and_replace'
      end

  end


end
