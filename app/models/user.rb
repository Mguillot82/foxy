class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :catches
  has_many :collections
  has_many :animals, through: :catches
  has_many :got_badges
  has_many :badges, through: :got_badges
  has_many :friendships

  validates :username, presence: true
end
