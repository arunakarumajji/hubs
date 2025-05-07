class StorySubmissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hub_and_challenge

  def new
    @story_submission = @challenge.story_submissions.new
    @user = current_user

    # Check if user can submit
    unless @challenge.user_can_execute?(@user)
      redirect_to hub_user_challenges_path(@hub, @user), alert: "You have already completed this challenge"
    end
  end

  def create
    @story_submission = @challenge.story_submissions.new(story_submission_params)
    @story_submission.user = current_user
    if @story_submission.save
    # Mark the challenge as completed and award points
    user_challenge = UserChallenge.find_or_create_by(user: current_user, challenge: @challenge)
    user_challenge.update(completed: true, points_awarded: @challenge.points)
    # Create activity record
    Activity.create(
      action: Activity::STORY_SUBMITTED,
      user: current_user,
      hub: @hub,
      trackable: @story_submission,
      data: {
        challenge_title: @challenge.title,
        story_title: @story_submission.title,
        points: @challenge.points
      }
    )

    redirect_to thank_you_hub_challenge_path(@hub, @challenge), notice: "Story submitted successfully! You earned #{@challenge.points} points."
  else
    render :new, status: :unprocessable_entity
  end
  end

  def thank_you
    @user = current_user

  end

  private

  def set_hub_and_challenge
    @hub = Hub.find(params[:hub_id])
    @challenge = @hub.challenges.find(params[:challenge_id])
    # Make sure it's a story challenge
    unless @challenge.challenge_type == "story"
      redirect_to hub_user_challenges_path(@hub, current_user), alert: "Invalid challenge type"
    end
  end

  def story_submission_params
    params.require(:story_submission).permit(:title, :content, :image)
  end
end