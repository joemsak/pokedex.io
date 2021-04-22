class User::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :guide_user_to_first_captures

  def show
    @pokemon = current_user.pokemon
  end

  private
  def guide_user_to_first_captures
    if current_user.captures.none?
      redirect_to pokemon_index_path
    end
  end
end
