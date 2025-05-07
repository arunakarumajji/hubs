class UserChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hub_and_user
  before_action :set_user_challenge, only: [:show, :complete]

  def index
    # Get all pending challenges for this user
    @pending_challenges = @user.user_challenges
                               .where(completed: false)
                               .includes(:challenge)
                               .map(&:challenge)

    # Get all completed challenges for this user
    @completed_challenges = @user.user_challenges
                                 .where(completed: true)
                                 .includes(:challenge)
                                 .map(&:challenge)

    # Calculate total points
    @total_points = @user.user_challenges.where(completed: true).sum(:points_awarded)
  end


  def show
    @challenge = Challenge.find(params[:id])
    @can_execute = @challenge.user_can_execute?(@user)

    # For story challenges, redirect to the story submission form
    if @challenge.challenge_type == "story" && @can_execute
      redirect_to new_hub_challenge_story_submission_path(@hub, @challenge)
    end
  end

  def complete

    # For share_link type challenges only
     if @challenge.share_link? && @challenge.user_can_execute?(@user)
       UserChallenge.find_or_create_by(user: @user, challenge: @challenge) do |uc|
         uc.completed = true
          uc.points_awarded = @challenge.points
       end
       redirect_to hub_user_challenges_path(@hub, @user), notice: "Challenge completed! You earned #{@user_challenge.points_awarded} points."
     else
       redirect_to hub_user_challenges_path(@hub, @user), alert: "You can't complete this challenge."
     end
  end

  private

  def set_hub_and_user
    @hub = Hub.find(params[:hub_id])
    @user = User.find(params[:user_id])

    unless current_user.id == @user.id
      redirect_to root_path, alert: "You don't have permission to access this"
    end
  end

  def set_user_challenge
    @user_challenge = UserChallenge.find_by(
      user_id: @user.id,
      challenge_id: params[:challenge_id] || params[:id]
    )

    unless @user_challenge
      redirect_to hub_user_challenges_path(@hub, @user), alert: "Challenge not found"
    end
  end
end