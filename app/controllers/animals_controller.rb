class AnimalsController < ApplicationController
  # animals GET    /animals(.:format) animals#index
  #         POST   /animals(.:format) animals#create
  # animal GET    /animals/:id(.:format)  animals#show

  before_action :set_animal, only: %i[show]

  def new
    @animal = Animal.new(animal_params)
    authorize @animal
    respond_to do |format|
      format.text { render partial: 'pages/animal_validation', locals: { animal: @animal }, formats: [:html] }
    end
  end

  def create
    @animal = Animal.find_or_create_by!(animal_params)
    authorize @animal
    respond_to do |format|
      format.json { render json: @animal }
    end
  end

  def show
    authorize @animal
  end

  def index
    if params[:query].present?
      @animals = policy_scope(Animal).animal_search(params[:query])
    else
      @animals = policy_scope(Animal)
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:taxonomy_id, :name, :scientific_name, :description, :location, :photo_url)
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end
end
