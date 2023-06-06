class Catch < ApplicationRecord
  belongs_to :animal, dependent: :destroy
  belongs_to :user, dependent: :destroy

  has_many :collections_catches
  has_one_attached :photo

  validates :location, presence: true
end
