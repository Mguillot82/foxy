class Catch < ApplicationRecord
  belongs_to :animal
  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  has_many :collections, through: :collections_catches
  has_one_attached :photo

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.location = geo.city
    end
  end
  after_validation :reverse_geocode
end
