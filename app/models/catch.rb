class Catch < ApplicationRecord
  belongs_to :animal, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :collections_catches
  validates :location, presence: true
end
