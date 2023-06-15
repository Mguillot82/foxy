class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[show add_catch update destroy remove_catch]
  skip_after_action :verify_policy_scoped

  def index
    @collections = CollectionPolicy::Scope.new(current_user, Collection, User.find(params[:user_id])).resolve
  end

  def show
    @catches = @collection.catches
    @catches_all = Catch.where(user_id: current_user)
    @catches_all = @catches_all.excluding(@catches)

    if params[:query].present?
      @catches = Catch.catch_search(params[:query]).joins(:collections_catches).where(user_id: params[:user_id]).where(collections_catches: {collection_id: params[:id]})
    end
    authorize @collection
  end

  def add_catch
    @added_catches = Catch.find(params[:catches])
    @collection.catches << @added_catches
    authorize @collection

    respond_to do |format|
      format.html
      format.text { render partial: "catches_collection", locals: { catches: @collection.catches }, formats: [:html] }
    end
  end

  def remove_catch
    @collections_catches = CollectionsCatch.find_by(collection_id: params[:id], catch_id: params[:catch])
    @collections_catches.destroy
    authorize @collection

    respond_to do |format|
      format.html
      format.text { render partial: "catches_collection", locals: { catches: @collection.catches }, formats: [:html] }
    end
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
