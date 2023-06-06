class Friendship < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :friend, class_name: "User",
                      foreign_key: "friend_id",
                      dependent: :destroy
  validates :status, presence: true
end
