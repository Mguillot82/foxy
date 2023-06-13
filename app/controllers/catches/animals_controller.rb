module Catches
  class AnimalsController < ApplicationController
    before_action :set_animal, :set_catch, only: [:show]

    def show
      authorize @catch
      @marker = {
        lat: @catch.latitude.to_f,
        lng: @catch.longitude.to_f
      }
    end

    def animal
    end

    def catch
    end

    private

    def set_animal
      @animal = Animal.find(params[:id])
    end

    def set_catch
      @catch =  Catch.find(params[:catch_id])
    end
  end
end
