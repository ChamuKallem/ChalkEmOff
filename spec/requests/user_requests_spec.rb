require 'rails_helper'
describe 'user_tests', type: :request do
  describe 'user unauthenticated ops' do

    it 'registration returns success for valid params' do
          post "/auth", params: {email: Faker::Internet.email, password: "12345678", password_confirmation: "12345678"}
          expect(response).to be_success
    end
    it 'a new user added' do
      expect{
        post "/auth", params: {email: Faker::Internet.email, password: "12345678", password_confirmation: "12345678"}
      }.to change(User, :count).by(1)
    end

  end

  describe 'POST /auth/sign_in (Sign In process)' do
    before do
      @email = Faker::Internet.email
      @password = Faker::Internet.password
    end
    it 'Should respond with status 200(OK)' do
    # Sign Up

      post user_registration_path(:email => @email, :password => @password)
      # post user_registration_path(:email => 'email@email.com', :password => 'qwertyuiop')

      #Sign In
      # post user_session_path(:email => 'email@email.com', :password => 'qwertyuiop')
      post user_session_path(:email => @email, :password => @password)
      expect(response).to be_success

    end
  end
  describe 'POST /auth/sign_in (Sign In process) invalid email' do
    before do
      @email = Faker::Internet.email
      @password = Faker::Internet.password
    end
    it 'Should respond with status 401(invalid)' do
    # Sign Up

      post user_registration_path(:email => @email, :password => @password)

      post user_session_path(:email => " ", :password => @password)
      expect(response).to have_http_status(401)

    end
  end
  describe 'PUT /auth/password (change password)' do
    before do
      @email = Faker::Internet.email
      @password = Faker::Internet.password
    end
    it 'Should respond with status success' do
    # Sign Up

      post user_registration_path(:email => @email, :password => @password)

      post user_session_path(:email => @email, :password => @password)
      puts "before"
      puts response.headers
      client_id = response.headers['client']
      token = response.headers['access-token']
      uid = response.headers['uid']
      @newpassword = "testpassword"
      put user_password_path(:uid => uid, :client => client_id, :'access-token' => token, :password => @newpassword, :password_confirmation => @newpassword)
      puts "after"
      puts response.headers
      expect(response).to be_success

    end
  end
    describe 'DELETE /auth/sign_out (Sign Out process)' do
      before do
        @email = Faker::Internet.email
        @password = Faker::Internet.password
      end
      it 'Should respond with status 200(OK)' do
        # Sign Up
        post user_registration_path(:email => @email, :password => @password)

        #Sign In
        post user_session_path(:email => @email, :password => @password)

        client_id = response.headers['client']
        token = response.headers['access-token']
        uid = response.headers['uid']
        #delete
        delete destroy_user_session_path(:uid => uid, :client => client_id, :'access-token' => token)
        expect(response).to be_success

      end
      end
end
