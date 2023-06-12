class CatchesController < ApplicationController
  def create
    @catch = Catch.new(catch_params)
    @catch.user = current_user
    @catch.collections << current_user.collections.first
    authorize @catch
    if @catch.save!
      respond_to do |format|
        format.html
        format.json { render json: @catch }
      end
    else
      redirect_to root_path
    end
  end

  private

  def catch_params
    params.require(:catch).permit(:animal_id, :latitude, :longitude)
  end
end
