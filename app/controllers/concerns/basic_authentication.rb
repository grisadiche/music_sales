module BasicAuthentication
  extend ActiveSupport::Concern

  class Error < StandardError
  end

  def authenticate_user_from_token!
    if user = find_user_token
      sign_in user, store: false
    else
      raise Error.new("user is not authorized")
    end
  end

  def find_user_token
    authenticate_with_http_basic do |email, token|
      user_email = email
      user       = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.api_key, token)
        user
      else
        false
      end
    end
  end
end
