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
    @challenge = @user_challenge.challenge
  end

  def complete
    @user_challenge.complete!
    redirect_to hub_user_challenges_path(@hub, @user), notice: "Challenge completed! You earned #{@user_challenge.points_awarded} points."
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