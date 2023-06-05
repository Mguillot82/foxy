class Badge < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :category, presence: true
end
