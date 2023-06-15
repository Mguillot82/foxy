class Catch < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :catch_search,
                  associated_against: {
                    animal: %i[name scientific_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
  belongs_to :animal
  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  has_many :collections, through: :collections_catches
  has_one_attached :photo

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    obj.location = geo.city
  end
  after_validation :reverse_geocode

  # Fetch all the curent user's catches given a taxonomy
  # Hash is required to pass to the method with user_id and taxonomy_id
  scope :user_catches_by_taxonomy, lambda { |params|
    joins(animal: :taxonomy).where(user_id: params[:user_id]).where('animals.taxonomy_id = ?', params[:taxonomy_id])
  }
end
