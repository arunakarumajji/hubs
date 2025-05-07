class ChallengesController < ApplicationController
before_action :authenticate_admin!
before_action :set_hub
before_action :set_challenge, only: [:edit, :update, :destroy]
before_action :check_admin_permission

def index
  @challenges = @hub.challenges
end

def new
  @challenge = @hub.challenges.new
  # Set a default challenge type
  @challenge.challenge_type = 'share_link'
end

def create
  @challenge = @hub.challenges.new(challenge_params)


  Rails.logger.debug "Challenge params: #{challenge_params.inspect}"
  Rails.logger.debug "Challenge type: #{@challenge.challenge_type}"

  if @challenge.save
    @hub.users.active.each do |user|
      # Create a UserChallenge for each active user
      UserChallenge.create(user: user, challenge: @challenge, completed: false)
    end
    redirect_to hub_challenges_path(@hub), notice: "Challenge created successfully"
  else
    Rails.logger.debug "Challenge full error message:#{@challenge.errors.full_messages}"
    render :new, status: :unprocessable_entity
  end
end

def edit
end

def update
  if @challenge.update(challenge_params)
    redirect_to hub_challenges_path(@hub), notice: "Challenge updated successfully"
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @challenge.destroy
  redirect_to hub_challenges_path(@hub), notice: "Challenge deleted successfully"
end


def assign
  @challenge = @hub.challenges.find(params[:id])
  @users = @hub.users.active
end

def process_assignment
  @challenge = @hub.challenges.find(params[:id])
  user_ids = params[:user_ids] || []

  if user_ids.empty?
    redirect_to hub_challenges_path(@hub), alert: "No users selected"
    return
  end

  count = 0
  user_ids.each do |user_id|
    user = @hub.users.find_by(id: user_id)
    next unless user

    # Don't create duplicate assignments
    unless UserChallenge.exists?(user_id: user_id, challenge_id: @challenge.id)
      UserChallenge.create(user: user, challenge: @challenge, completed: false)
      count += 1
    end
  end

  redirect_to hub_challenges_path(@hub), notice: "Challenge assigned to #{count} users"
end



private

def set_hub
  @hub = Hub.find(params[:hub_id])
end

def set_challenge
  @challenge = @hub.challenges.find(params[:id])
end

def check_admin_permission
  unless current_admin.hub_id == @hub.id
    redirect_to hubs_path, alert: "You don't have permission to access this"
  end
end

def challenge_params
  params.require(:challenge).permit(:title, :description, :sharing_link, :image, :points, :challenge_type, :execution_limit)
end
end