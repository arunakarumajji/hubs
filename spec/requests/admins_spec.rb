require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/admins/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admins/create"
      expect(response).to have_http_status(:success)
    end
  end

end
