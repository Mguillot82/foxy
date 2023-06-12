class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[show add_catch update destroy]

  def index
    @collections = policy_scope(Collection)
  end

  def show
    @catches = @collection.catches
    @catches_all = Catch.where(user_id: current_user)
    authorize @collection
  end

  def add_catch
    
  end

  def general
    @collection = CollectionPolicy::Scope.new(current_user, Collection, User.find(params[:user_id])).resolve
    @animals = @collection.first.catches.map(&:animal)
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
    if @collection.update(collection_params)
      authorize @collection
      redirect_to user_collection_path(current_user, @collection)
    else
      render 'index', status: :unprocessable_entity
    end
  end

  def destroy
    @collection.destroy
    authorize @collection

    redirect_to user_collections_path(current_user)
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end

  def set_collection
    @collection = Collection.find(params[:id])
  end
end
