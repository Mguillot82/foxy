class Animal < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :animal_search,
                  against: %i[name location],
                  associated_against: { taxonomy: %i[name] },
                  using: { tsearch: { prefix: true } }

  belongs_to :taxonomy
  has_many :catches, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :scientific_name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location, presence: true
end
