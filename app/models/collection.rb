class Collection < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :collections_catches
  validates :name, presence: true
  validates :description, presence: true
end
