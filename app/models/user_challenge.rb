class UserChallenge < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  validates :user_id, uniqueness: { scope: :challenge_id, message: "User has already completed this challenge" }

  def complete!
    update(completed: true, points_awarded: challenge.points)
  end
end
