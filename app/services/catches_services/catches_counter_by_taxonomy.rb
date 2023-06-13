module CatchesServices
  class CatchesCounterByTaxonomy < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      Catch.user_catches_by_taxonomy(@params).count
    end
  end
end
