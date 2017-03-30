module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def sign_in
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    user = User.create(email: @email, password: @password)
    post user_registration_path(:email => user.email, :password => user.password)
    post user_session_path(:email => user.email, :password => user.password)
    user
  end
end
