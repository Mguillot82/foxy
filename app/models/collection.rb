class Collection < ApplicationRecord
  belongs_to :user
  has_many :collections_catches
  validates :name, presence: true
  validates :description, presence: true
end
