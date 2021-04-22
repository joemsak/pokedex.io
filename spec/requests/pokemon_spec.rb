require 'rails_helper'

RSpec.describe "Pokemon", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/pokemon/index"
      expect(response).to have_http_status(:success)
    end
  end

end
