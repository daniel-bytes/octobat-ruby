module Octobat
  class ExportsSetting < APIResource
    include Octobat::APIOperations::Create
    include Octobat::APIOperations::Update

    def self.default(params = {}, opts={})
      api_key, headers = Util.parse_opts(opts)
      api_key ||= @api_key
      opts[:api_key] = api_key

      instance = self.new(nil, opts)

      response, api_key = Octobat.request(:get, url + '/default', api_key, params)
      instance.refresh_from(response, api_key)
      instance
    end

  end
end
