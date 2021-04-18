require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET #new" do
    it "returns http success" do
      get new_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user, username: "ash") }

    let(:credentials) do
      { username: "ash", password: "secret1234" }
    end

    it "signs in valid login attempts" do
      allow_any_instance_of(User).to receive(:auth_token) { "abc123" }
      post sessions_path, params: credentials
      expect(session[ApplicationController::AUTH_TOKEN]).to eq("abc123")
    end

    it "redirects to the user dashboard" do
      post sessions_path, params: credentials
      expect(response).to redirect_to(user_dashboard_path)
    end

    context "with remember_me checked" do
      it "remembers permanently in an encrypted cookie" do
        allow_any_instance_of(User).to receive(:auth_token) { "abc123" }

        test_cookies = double(:cookies)

        allow(test_cookies).to receive_messages(
          encrypted: test_cookies,
          permanent: test_cookies,
          :[]= => {}
        )

        allow_any_instance_of(SessionsController).to receive(:cookies)
          .and_return(test_cookies)

        post sessions_path, params: credentials.merge(remember_me: true)

        expect(test_cookies).to have_received(:encrypted)
        expect(test_cookies).to have_received(:permanent)
        expect(test_cookies).to have_received(:[]=)
          .with(ApplicationController::AUTH_TOKEN, "abc123")
      end
    end

    it "resets the user's auth token" do
      expect {
        post sessions_path, params: credentials
      }.to change {
        user.reload.auth_token
      }
    end
  end
end
