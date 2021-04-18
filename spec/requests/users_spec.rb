require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #new" do
    it "returns http success" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      expect {
        post users_path, params: {
          user: {
            username: "ash",
            email: "ash@example.org",
            password: "ash12345",
            password_confirmation: "ash12345",
          }
        }
      }.to change {
        User.count
      }.from(0).to(1)

      user = User.last
      expect(user.username).to eq("ash")
      expect(user.email).to eq("ash@example.org")
      expect(user.authenticate("ash12345")).to eq(user)
    end

    it "signs the user in" do
      post users_path, params: { user: attributes_for(:user) }
      expect(session[ApplicationController::AUTH_TOKEN]).to eq(User.last.auth_token)
    end

    it "redirects the user to their dashboard" do
      post users_path, params: { user: attributes_for(:user) }
      expect(response).to redirect_to user_dashboard_path
    end
  end
end
