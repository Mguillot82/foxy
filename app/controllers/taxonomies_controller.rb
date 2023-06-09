class TaxonomiesController < ApplicationController
  def create
    # name = params[:taxonomy][:name]
    @taxonomy = Taxonomy.find_or_create_by(taxonomy_params)
    respond_to do |format|
      format.json { render json: @taxonomy }
    end
    authorize @taxonomy
  end

  private

  def taxonomy_params
    params.require(:taxonomy).permit(:name)
  end
end
