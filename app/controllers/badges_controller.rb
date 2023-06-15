class BadgesController < ApplicationController
  before_action :set_taxonomy
  skip_after_action :verify_authorized

  def grant_user_badge
    badges = Badge.find(BadgesManager::BadgesUpdater.call(@taxonomy, current_user))
    if badges.empty?
      respond_to do |f|
        f.json { render json: {badge: nil}}
      end
    end

    badges.each do |badge|
      @got_badge = new_got_badges(badge.id)
      next unless @got_badge.save

      respond_to do |format|
        format.html
        format.json { render json: {badge: @got_badge} }
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
