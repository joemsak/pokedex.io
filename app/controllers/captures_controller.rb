class CapturesController < ApplicationController
  def create
    @pokemon = Pokemon.friendly.find(capture_params[:pokemon_id])
    @capture = current_user.captures.create!(pokemon: @pokemon)
    redirect_to pokemon_index_path, notice: t(".success")
  end

  def destroy
    @capture = current_user.captures.find(params[:id])
    @capture.destroy
    redirect_to pokemon_index_path, notice: t(".success")
  end

  private
  def capture_params
    params.permit(:pokemon_id)
  end
end
