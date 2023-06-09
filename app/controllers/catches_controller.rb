class CatchesController < ApplicationController
  def create
    @catch = Catch.new
    @catch.user = current_user
    @catch.animal = Animal.find(params[:catch][:animal])
    @catch.latitude = params[:catch][:latitude]
    @catch.longitude = params[:catch][:longitude]
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
end
