class StorySubmission < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_one_attached :image
  validates :title, :content, presence: true
  # after_create :award_points

  # private
  # def award_points
  #   UserChallenge.find_or_create_by(user: user, challenge: challenge) do |uc|
  #     uc.completed = true
  #     uc.points_awarded = challenge.points
  #   end
  # end
end