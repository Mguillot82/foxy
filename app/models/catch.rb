class Catch < ApplicationRecord
  belongs_to :animal
  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  has_one_attached :photo

  validates :location, presence: true

  geocoded_by :city_location
  after_validation :geocode, if:
  :will_save_change_to_address?
end
