def generate_token(email, password)
  Session::Base.new(
    email,
    password
  ).()
end

def login_with(user, cookies)
  access_token, refresh_token = generate_token(user.email, user.password)
  cookies['access_token'] = access_token
  cookies['refresh_token'] = refresh_token
end