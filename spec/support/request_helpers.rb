module Requests
  module JsonHelpers
    def parsed_response
      @_parsed_response ||= JSON.parse(response.body)
    end
  end
end
