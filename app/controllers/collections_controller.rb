class CollectionsController < ApplicationController
  def index
    @collections = policy_scope(Collection)
    @collection = Collection.new
  end

  def show
    @collection = Collection.find(params[:id])
    authorize @collection
  end

  def general
    # if user_id == current_user
    # @collection = current_user.collections.first
    @collection = CollectionPolicy::Scope.new(current_user, Collection, User.find(params[:user_id])).resolve
    # raise
    authorize @collection
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user
    if @collection.save!
      authorize @collection
      redirect_to user_collection_path(current_user, @collection)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update(collection_params)
      authorize @collection
      redirect_to user_collection_path(current_user, @collection)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    authorize @collection

    redirect_to user_collections_path(current_user)
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
