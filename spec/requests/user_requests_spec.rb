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
      it 'Should respond with status 200(OK)' do
        # Sign Up
        @email = Faker::Internet.email
        @password = Faker::Internet.password
        post user_registration_path(:email => @email, :password => @password)
        # post user_registration_path(:email => 'email@email.com', :password => 'qwertyuiop')

        #Sign In
        # post user_session_path(:email => 'email@email.com', :password => 'qwertyuiop')
        post user_session_path(:email => @email, :password => @password)
        expect(response).to be_success

      end
    end
    describe 'DELETE /auth/sign_out (Sign Out process)' do
        it 'Should respond with status 200(OK)' do
          # Sign Up
          post user_registration_path(:email => 'email@email.com', :password => 'qwertyuiop')

          #Sign In
          post user_session_path(:email => 'email@email.com', :password => 'qwertyuiop')

          client_id = response.headers['client']
          token = response.headers['access-token']
          uid = response.headers['uid']
          puts client_id
          puts token
          puts uid
          #delete
          delete destroy_user_session_path(:uid => uid, :client => client_id, :'access-token' => token)
          expect(response).to be_success

        end
      end
end
