class PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.paginate(page: params[:page])
  end
end
