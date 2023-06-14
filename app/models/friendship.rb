class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User",
                      foreign_key: "friend_id"
  validates :status, inclusion: { in: ["pending", "accepted", "rejected"] }
  validate :user_cannot_be_friend

  private

  def user_cannot_be_friend
    errors.add(:friend) if user == friend
  end
end
