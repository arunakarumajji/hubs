class Challenge < ApplicationRecord
  belongs_to :hub
  has_many :user_challenges, dependent: :destroy
  has_many :users, through: :user_challenges
  validates :title, :description, :sharing_link, :points,  presence: true
  validates :points, numericality: { greater_than: 0}
  # Add active storage association for image
  has_one_attached :image

  def completed_by_user?(user)
    user_challenges.where(user: user, completed: true).exists?
  end

end
