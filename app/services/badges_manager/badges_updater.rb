module BadgesManager
  # return an activeRecord_Relation with badge's instances
  # that current user is entitled to obtain
  class BadgesUpdater < ApplicationService
    def initialize(taxonomy, user)
      @taxonomy = taxonomy
      @user = user
    end

    def call
      params = { user_id: @user.id, user_badges: @user.got_badges, taxonomy_id: @taxonomy.id, taxonomy: @taxonomy.name }
      counter = CatchesServices::CatchesCounterByTaxonomy.call(params)
      params[:counter] = counter
      badges = BadgesManager::BadgesGetter.call(params)
      params[:badges] = badges
      pending_badges = BadgesManager::BadgesChecker.call(params)
      return pending_badges
    end
  end
end
