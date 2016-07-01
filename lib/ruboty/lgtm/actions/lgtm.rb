require 'net/http'
require 'oga'

module Ruboty
  module LGTM
    module Actions
      class LGTM < Ruboty::Actions::Base
        def call
          message.reply(get_lgtm_image_url)
        end

        def get_lgtm_image_url
          res = ''
          begin
            res = Oga.parse_html(http_get(URI.parse('http://www.lgtm.in/g'))).css('#imageUrl')[0].get('value')
          end

          res
        end

		def http_get(uri)
		  5.times do |retry_count|
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true if uri.scheme == 'https'

			res = http.get(uri.path)
			case res
			when Net::HTTPSuccess
			  return res.body
			when Net::HTTPRedirection
			  uri = URI.parse(res['Location'])
			  next
			end
		  end
		end
      end
    end
  end
end
