require 'rails_helper'

RSpec.describe "Healths", type: :request do
  describe "GET /health_check" do
    it "returns http success" do
      get '/health_check'
      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:status]).to eq('ok')
      expect(response.status).to eq(200)
    end
  end
end
