module UsersHelper
  def create_api_key(current_user)
    if current_user.api_key
      current_user.api_key
    else
      flash[:success] = "You added an API Key for: #{current_user.email}."
      api_key_generate = FFaker::HipsterIpsum.paragraph.delete(' ')[0...49]
      current_user.update(api_key: api_key_generate)
    end
  end
end
