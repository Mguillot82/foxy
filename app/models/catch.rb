class Catch < ApplicationRecord
  belongs_to :animal
  belongs_to :user

  has_many :collections_catches
  has_one_attached :photo

  validates :location, presence: true
end
