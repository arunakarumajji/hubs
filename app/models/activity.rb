class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :hub
  belongs_to :trackable, polymorphic: true, optional: true

  scope :recent, -> { order(created_at: :desc) }

  # Activity types
  CHALLENGE_COMPLETED = "challenge_completed"
  STORY_SUBMITTED = "story_submitted"
  STORY_APPROVED = "story_approved"
  USER_JOINED = "user_joined"
end
