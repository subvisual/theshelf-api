class SessionsController < Clearance::SessionsController
  layout 'simple'

  def url_after_destroy
    log_in_url
  end
end
