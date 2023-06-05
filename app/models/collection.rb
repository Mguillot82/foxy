class Collection < ApplicationRecord
  belongs_to :user
  has_many :collections_catches
end
