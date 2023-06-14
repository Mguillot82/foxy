module BadgesManager
  # from badges instances, checks if a user already has it
  # return badges user doesn't have
  class BadgesChecker < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      pending_badges_id = []
      user_badges = []
      @params[:user_badges].each do |badge|
        user_badges << badge.badge_id
      end
      @params[:badges].each do |badge_id|
        pending_badges_id << badge_id unless user_badges.include?(badge_id)
      end
      return pending_badges_id
      # matched_badges = user_badges.where(badge_id: @params[:badges])
    end
  end
end
