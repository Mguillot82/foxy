class CatchesController < ApplicationController
  def create
    authorize @catch
    @catch = Catch.new
    @catch.user = current_user
    @catch.animal = animal
    @catch.latitude = latitude
    @catch.longitude = longitude
    @catch.location = 'Toulouse'
  end
end
