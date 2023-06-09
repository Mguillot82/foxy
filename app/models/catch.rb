class Catch < ApplicationRecord
  belongs_to :animal
  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  has_one_attached :photo

  validates :location, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
