class CollectionsController < ApplicationController
  def show
    @collection = Collection.find(params[:id])
    authorize @collection
  end
end
