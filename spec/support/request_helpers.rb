module Requests
  module JsonHelpers
    def parsed_response
      @_parsed_response ||= JSON.parse(response.body, symbolize_names: true)
    end

    def request_header(version: 1)
      {'Accept' => "application/json; version=#{version}"}
    end

    def authenticated_request_header(version: 1, user: user)
      request_header(version: version).merge('Authorization' => token_encoder(user.authentication_token))
    end

    def token_encoder(token)
      ActionController::HttpAuthentication::Token.encode_credentials(token)
    end
  end
end
