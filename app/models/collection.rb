class Collection < ApplicationRecord
  # include PgSearch::Model
  # pg_search_scope :catch_search,

  belongs_to :user
  has_many :collections_catches, dependent: :destroy
  has_many :catches, through: :collections_catches

  validates :name, presence: true
  validates :description, presence: true
end
