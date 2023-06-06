class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :catches, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :animals, through: :catches
  has_many :got_badges, dependent: :destroy
  has_many :badges, through: :got_badges
  has_many :friendships, dependent: :destroy
  has_one_attached :photo

  validates :username, presence: true, uniqueness: true
end
