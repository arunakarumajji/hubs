require 'rails_helper'

RSpec.describe "EmailConfigs", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/email_configs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/email_configs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/email_configs/update"
      expect(response).to have_http_status(:success)
    end
  end

end
