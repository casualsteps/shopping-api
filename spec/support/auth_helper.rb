module AuthHelper
  def auth_with_user(user)
    request.headers['X-ACCESS-TOKEN'] = user.api_key
  end

  def clear_token
    request.headers['X-ACCESS-TOKEN'] = nil
  end
end