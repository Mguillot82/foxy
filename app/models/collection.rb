class Collection < ApplicationRecord
  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  has_many :catches, through: :collection_catches

  validates :name, presence: true
  validates :description, presence: true
end
