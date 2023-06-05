class Catch < ApplicationRecord
  belongs_to :animal
  belongs_to :user
  has_many :collections_catches
end
