class ApiRequest
  def initialize(request)
    @request = request
  end

  def user_token?
    request.headers['Authorization'].present?
  end

  def user_token
    request.headers['Authorization'].split(' ')[1].split('=')[1]
  end

  private
  attr_reader :request
end
