
module ActivitiesHelper
  def activity_icon_class(action)
    case action
    when Activity::CHALLENGE_COMPLETED
      "bg-green-100 text-green-800"
    when Activity::STORY_SUBMITTED
      "bg-blue-100 text-blue-800"
    when Activity::USER_JOINED
      "bg-purple-100 text-purple-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end

  def activity_title(activity)
    case activity.action
    when Activity::CHALLENGE_COMPLETED
      "Challenge Completed"
    when Activity::STORY_SUBMITTED
      "Story Submitted"
    when Activity::USER_JOINED
      "New User Joined"
    else
      "Activity"
    end
  end

  def activity_description(activity)
    case activity.action
    when Activity::CHALLENGE_COMPLETED
      "#{activity.user.full_name} completed the \"#{activity.data['challenge_title']}\" challenge"
    when Activity::STORY_SUBMITTED
      "#{activity.user.full_name} submitted a story \"#{activity.data['story_title']}\" for the \"#{activity.data['challenge_title']}\" challenge"
    when Activity::USER_JOINED
      "#{activity.user.full_name} (#{activity.user.email}) joined the hub"
    else
      "Activity occurred"
    end
  end
end