require 'rails_helper'

RSpec.describe "Signups", type: :request do
  describe "POST /v1/sign_up" do
    context "with valid params" do
      it "creates a new user" do
        post '/v1/sign_up', params: FactoryBot.attributes_for(:user)
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(200)
        expect(json[:message]).to eq('Success')
      end 
    end

    context "with invalid params" do
      it "email is blank" do
        post '/v1/sign_up', params: FactoryBot.attributes_for(:user).merge(email: '')
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(400)
        expect(json[:message]).to eq(['Email can\'t be blank', 'Email is invalid'])
      end

      it "email is not valid" do
        post '/v1/sign_up', params: FactoryBot.attributes_for(:user).merge(email: 'example.com')
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(400)
        expect(json[:message]).to eq(['Email is invalid'])
      end

      it "password invalid" do
        post '/v1/sign_up', params: FactoryBot.attributes_for(:user).merge(password: 'password', password_confirmation: 'password123 ')
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(400)
        expect(json[:message]).to eq(['Password confirmation doesn\'t match Password'])
      end
    end
  end 
end
