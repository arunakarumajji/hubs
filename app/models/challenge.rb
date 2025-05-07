class Challenge < ApplicationRecord
  belongs_to :hub
  has_many :user_challenges, dependent: :destroy
  has_many :users, through: :user_challenges
  has_many :story_submissions, dependent: :destroy
  validates :title, :description,  :points,  presence: true
  validates :points, numericality: { greater_than: 0}
  validates :sharing_link, presence: true, if: -> { challenge_type == "share_link" }
  # Add active storage association for image
  has_one_attached :image
  enum :challenge_type, { share_link: 0, story: 1 }
  enum :execution_limit, { once: 0, un_limited: 1 }



  def completed_by_user?(user)
    user_challenges.where(user: user, completed: true).exists?
  end

  def user_can_execute?(user)
    return true if execution_limit == "un_limited"

    completed_count = user_challenges.where(user: user, completed: true).count
    completed_count == 0
  end



end
