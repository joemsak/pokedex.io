require 'rails_helper'

RSpec.describe "User::Dashboards", type: :request do
  describe "GET #show" do
    before { sign_in(:user) }
    after { sign_out }

    context "users without captured pokemon" do
      it "redirects to the pokemon listing" do
        get user_dashboard_path
        expect(response).to redirect_to(pokemon_index_path)
      end
    end

    context "users with captured pokemon" do
      before { create(:capture, user: User.last) }

      it "redirects to the pokemon listing" do
        get user_dashboard_path
        expect(response).to render_template('user/dashboards/show')
      end
    end
  end
end
