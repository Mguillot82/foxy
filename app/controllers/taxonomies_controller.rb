class TaxonomiesController < ApplicationController
  def create
    # name = params[:taxonomy][:name]
    @taxonomy = Taxonomy.find_or_create_by(taxonomy_params)
    authorize @taxonomy
    respond_to do |format|
      format.json { render json: @taxonomy }
    end
  end

  private

  def taxonomy_params
    params.require(:taxonomy).permit(:name)
  end
end
