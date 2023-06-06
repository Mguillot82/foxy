class GotBadge < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :badge, dependent: :destroy
end
