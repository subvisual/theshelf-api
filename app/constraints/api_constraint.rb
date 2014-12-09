# http://www.bignerdranch.com/blog/adding-versions-rails-api/
class ApiConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request.headers.fetch(:accept).include?("vnd.theshelf.v#{version}")
  end
end
