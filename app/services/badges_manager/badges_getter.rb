module BadgesManager
  # return an array of badges ids
  # that current user is entitled to obtain
  class BadgesGetter < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      badges = []
      Badge.badges_by_condition(@params).each do |badge|
        badges << badge.id
      end
      return badges
    end
  end
end
