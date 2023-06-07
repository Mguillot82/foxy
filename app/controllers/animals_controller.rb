class AnimalsController < ApplicationController
  # animals GET    /animals(.:format) animals#index                                                                                animals#index
  #         POST   /animals(.:format) animals#create                                                                  animals#create
  # animal GET    /animals/:id(.:format)  animals#show                                                                animals#show

  before_action :set_animal, only: %i[show]
  before_action :set_user, only: %i[create]

  def create
    @animal = Animal.new(animal_params)
    if @animal.save!
      redirect_to catches_path(@user)
    else
      render catches_path(@user), status: :unprocessable_entity
    end
  end

  def show
    @animal
  end

  def index
    @animals = Animal.all
  end

  private

  def animal_params
    params.require(:animal).permit(:taxonomy_id, :name, :scientific_name, :description, :location, :photo_url)
  end

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
