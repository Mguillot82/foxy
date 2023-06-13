class BadgesController < ApplicationController
  before_action :set_taxonomy

  def set_badge
    BadgesManager::BadgesUpdater.call(taxonomy, current_user)
  end

  private

  def set_taxonomy
    taxonomy = Taxonomy.find(params[:taxonomy_id])
  end
end
