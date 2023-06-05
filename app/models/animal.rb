class Animal < ApplicationRecord
  belongs_to :taxonomy
  has_many :catches
  validates :name, presence: true
  validates :scientific_name, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
