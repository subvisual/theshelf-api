module Authenticable
  def self.included(base)
    base.class_eval do
      before_save :ensure_authentication_token
    end
  end

  private

  def ensure_authentication_token
    return unless authentication_token.blank?

    self.authentication_token = generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = SecureRandom.urlsafe_base64(nil, false)
      break token unless User.where(authentication_token: token).first
    end
  end
end
