class AnimalsController < ApplicationController
  # animals GET    /animals(.:format) animals#index
  #         POST   /animals(.:format) animals#create
  # animal GET    /animals/:id(.:format)  animals#show

  before_action :set_animal, only: %i[show]

  def create
    @animal = Animal.find_or_create_by(animal_params)
    authorize @animal
    respond_to do |format|
      format.json { render json: @animal.to_json }
    end
  end

  def show
    authorize @animal
  end

  def index
    @animals = policy_scope(Animal)
  end

  private

  def animal_params
    params.require(:animal).permit(:taxonomy_id, :name, :scientific_name, :description, :location, :photo_url)
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end
end
