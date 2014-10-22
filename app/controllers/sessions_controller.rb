class SessionsController < ApplicationController
  layout 'simple'

  def url_after_destroy
    log_in_url
  end
end
