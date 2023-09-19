require 'rails_helper'
RSpec.describe "V1::Links", type: :request do
  describe "POST /v1/auth" do
    context "with valid params" do
      let(:password) { 'password' }
      let (:user) { FactoryBot.create(:user, :password => password, :password_confirmation => password) }
      it "creates a new user" do
        post '/v1/auth', params: { auth: {email: user.email, password: password }}
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(200)
        expect(json[:message]).to eq('Success')
      end 
    end

    context "with invalid params" do
      let(:password) { 'password' }
      let (:user) { FactoryBot.create(:user, :password => password, :password_confirmation => password) }
      it "not wrong password" do
        post '/v1/auth', params: { auth: {email: user.email, password: password + '123' }}
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(400)
        expect(json[:message]).to eq('invalid_credentials')
      end

      it "not wrong email" do
        
        post '/v1/auth', params: { auth: {email: user.email + '123', password: password }}
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(400)
        expect(json[:message]).to eq('invalid_credentials')
      end
    end
  end
  
  describe "Get /v1/auth" do
    it "valid token" do
    end 
  end

  describe "Logout" do
    context 'user logged in' do
      before(:context) do
        @password = 'password'
        @user = FactoryBot.create(:user, :password => @password, :password_confirmation => @password)
      end

      before do
        login_with(@user, cookies)
      end

      it "success logout" do
        delete '/v1/auth'
        response_cookies = response.cookies
        expect(response.status).to eq(200)
        expect(response_cookies['access_token']).to eq(nil)
        expect(response_cookies['refresh_token']).to eq(nil)
      end
    end 

    context 'user not logged in' do
      it " failed logout" do
        delete '/v1/auth'
        expect(response.status).to eq(401)
      end
    end
  end

  describe "Refresh token" do
    context 'user logged in' do
      before(:context) do
        @password = 'password'
        @user = FactoryBot.create(:user, :password => @password, :password_confirmation => @password)
      end

      before do
        login_with(@user, cookies)
      end

      it "success refresh token" do
        put '/v1/auth'
        expect(response.status).to eq(200)
        response_cookies = response.cookies
        expect(response_cookies['access_token'].present?).to eq(true)
        expect(response_cookies['refresh_token'].present?).to eq(true)
      end
    end 
  end
end
