class Collection < ApplicationRecord
  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
