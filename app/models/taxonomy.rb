class Taxonomy < ApplicationRecord
  has_many :animals
  has_many :catches, through: :animals
end
