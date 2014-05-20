# encoding: UTF-8
require 'sinatra/base'

module Sinatra
  module ResponseFormat
    def format_response(data, format)
      response = case format
                 when 'text/xml' then data.to_xml
                 when 'application/json' then data.to_json
                 when 'text/x-yaml' then data.to_yaml
                 when 'text/csv' then data.to_csv
                 else data.to_json
                 end
      return response
    end

    def format_by_extensions(extension)
      result = { 
        'xml' => 'text/xml', 
        'json' => 'application/json',
        'yaml' => 'text/x-yaml',
        'csv' => 'text/csv'}
      return result[extension]
    end
  end
  helpers ResponseFormat
end
