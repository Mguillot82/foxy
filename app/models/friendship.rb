class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User",
                      foreign_key: "friend_id"
  validates :status, inclusion: { in: ["pending", "accepted", "refused"] }
end
