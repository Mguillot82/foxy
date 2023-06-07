class TaxonomiesController < ApplicationController
  def create
    # name = params[:taxonomy][:name]
    @taxonomy = Taxonomy.new(taxonomy_params)
    authorize @taxonomy if @taxonomy.save
  end

  private

  def taxonomy_params
    params.require(:taxonomy).permit(:name)
  end
end
