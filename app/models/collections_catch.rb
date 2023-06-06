class CollectionsCatch < ApplicationRecord
  belongs_to :collection, dependent: :destroy
  belongs_to :catch, dependent: :destroy
end
