require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class ExactOnlineUS < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://start.exactonline.com',
        authorize_url: '/api/oauth2/auth',
        token_url: '/api/oauth2/token'
      }

      def request_phase
        super
      end

      uid { raw_info['feed']['entry']['content']['properties']['UserID']['__content__'] }

      info do
        {
          name: raw_info['feed']['entry']['content']['properties']['FullName'],
          email: raw_info['feed']['entry']['content']['properties']['Email'],
          division: raw_info['feed']['entry']['content']['properties']['CurrentDivision']['__content__']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/current/Me').parsed
      end
    end
  end
end
