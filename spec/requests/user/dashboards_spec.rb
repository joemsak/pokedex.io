require 'rails_helper'

RSpec.describe "User::Dashboards", type: :request do
  describe "GET #show" do
    before { sign_in(:user) }
    after { sign_out }

    it "returns http success" do
      get user_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end
end
