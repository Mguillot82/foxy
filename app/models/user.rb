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
  has_many :friends, through: :friendships
  has_one_attached :photo

  validates :username, presence: true, uniqueness: true

  scope :accepted_friendships, -> { joins(:friendships).where(friendships: { status: 'accepted' }).distinct }
  scope :pending_friendships, -> { joins(:friendships).where(friendships: { status: 'pending' }).distinct }

  after_save :create_general_collection

  private

  def create_general_collection
    @general_collection = Collection.find_or_create_by(name: 'General', description: 'Your general collection with all your catches', user: self)
  end
end
