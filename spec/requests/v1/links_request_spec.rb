require 'rails_helper'

RSpec.describe "V1::Links", type: :request do
  describe "POST /v1/links" do
    before(:context) do
      @password = 'password'
      @user = FactoryBot.create(:user, :password => @password, :password_confirmation => @password)
    end

    context "with valid params" do
      let(:links) { FactoryBot.create_list(:link, 20, sharer: @user) }
      let(:default_per_page) { 10 }
      let(:max_per_page) { 15 }

      before do
        login_with(@user, cookies)
      end

      it "lists links without pagigation" do
        expect_links = serialize(links)
        
        get '/v1/links'
        
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(200)
        expect(json[:data]).to eq(expect_links[0...default_per_page])
      end 

      it "with per page = 5" do
        expect_links = serialize(links)
        
        get '/v1/links?page=1&per_page=5'
        
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(200)
        expect(json[:data]).to eq(expect_links[0...5])
      end

      it "with per page > max per page" do
        expect_links = serialize(links)
        
        get '/v1/links?page=1&per_page=20'
        
        json = JSON.parse(response.body).deep_symbolize_keys

        expect(response.status).to eq(200)
        expect(json[:data]).to eq(expect_links[0...max_per_page])
      end
    end
  end

  def serialize(links)
    links.map do |link|
      {
        id: link.id, 
        url: link.url,
        description: link.description, 
        title: link.title,
        shared_by: link.sharer&.email
      }
    end
  end
end
