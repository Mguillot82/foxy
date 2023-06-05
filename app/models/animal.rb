class Animal < ApplicationRecord
  belongs_to :taxonomy
  has_many :catches
end
