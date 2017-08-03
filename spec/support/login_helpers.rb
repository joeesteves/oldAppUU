module LoginHelpers
  def login_user
    before(:each) do
      @resource = ba_usuarios(:usuario)
      @auth_headers = @resource.create_new_auth_token

      @token     = @auth_headers['access-token']
      @client_id = @auth_headers['client']
      @expiry    = @auth_headers['expiry']

      age_token(@resource, @client_id)
      get '/mi/perfil', {}, @auth_headers

      @resp_token       = response.headers['access-token']
      @resp_client_id   = response.headers['client']
      @resp_expiry      = response.headers['expiry']
      @resp_uid         = response.headers['uid']
    end
  end

  def age_token(user, client_id)
    if user.tokens[client_id]
      user.tokens[client_id]['updated_at'] = Time.now - (DeviseTokenAuth.batch_request_buffer_throttle + 10.seconds)
      user.save!
    end
  end

  def expire_token(user, client_id)
    if user.tokens[client_id]
      user.tokens[client_id]['expiry'] = (Time.now - (DeviseTokenAuth.token_lifespan.to_f + 10.seconds)).to_i
      user.save!
    end
  end


end
