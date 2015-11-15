require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      # change the class name and the :name option to match your application name
      option :name, :doorkeeper

      option :client_options, {
        :site => "http://localhost:3000/",
        :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
          :email => raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me.json').parsed
      end
    end
  end
end

ENV['DOORKEEPER_APP_ID'] = 'c4724881bbeca45096393dc1c74fe153d64505d703aa75b2c9d41f4513d8770b'
ENV['DOORKEEPER_APP_SECRET'] = '1946be05474955c99073c2bfd49c651036387ae0a9a49c1132ecd2fc35dcfc9c'

Devise.setup do |config|
  config.omniauth :doorkeeper, ENV['DOORKEEPER_APP_ID'], ENV['DOORKEEPER_APP_SECRET']
end

=begin
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
=end
