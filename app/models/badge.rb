class Badge < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :category, presence: true

  has_many :got_badges, dependent: :destroy
  has_one_attached :photo

  scope :badges_from_category, lambda { |taxonomy|
    where('category = ?', taxonomy)
  }
  scope :badges_by_condition, lambda { |params|
    where(category: params[:taxonomy]).where('badges.condition <= ?', params[:counter])
  }
end
