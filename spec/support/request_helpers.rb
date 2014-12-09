module RequestHelpers
  def parsed_response
    @_parsed_response ||= JSON.parse(response.body, symbolize_names: true)
  end

  def request_header(version: 1)
    { 'Accept' => "application/vnd.theshelf.v#{version}+json" }
  end

  def authenticated_request_header(version: 1, user: nil)
    request_header(version: version).merge('Authorization' => token_encoder(user.authentication_token))
  end

  def token_encoder(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end

  def user
    @_user ||= create(:user)
  end
end
