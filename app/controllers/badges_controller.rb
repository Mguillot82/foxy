class BadgesController < ApplicationController
  before_action :set_taxonomy

  def grant_user_badge
    badges = Badge.find(BadgesManager::BadgesUpdater.call(@taxonomy, current_user))
    return if badges.empty?

    badges.each do |badge|
      @got_badge = new_got_badges(badge.id)
      next unless @got_badge.save
      authorize @got_badge, policy_class: BadgePolicy

      respond_to do |format|
        format.html
        format.json { render json: @got_badge }
      end
    end
  end

  private

  def set_taxonomy
    @taxonomy = Taxonomy.find(params[:taxonomy_id])
  end

  def new_got_badges(badge_id)
    GotBadge.new(user_id: current_user.id, badge_id:)
  end
end
