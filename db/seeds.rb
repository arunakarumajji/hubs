# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require 'open-uri'
#
# challenge = Challenge.create!(
#   hub: Faker::Company.name,
#   title: Faker::Company.catch_phrase,
#   description: Faker::Lorem.paragraph,
#   sharing_link: Faker::Internet.url,
#   points: 100
#   )
#
# challenge.image.attach(
#   io: URI.open(Faker::Company.logo),
#   filename: Faker::Company.name+".jpg",
#   content_type: "image/jpg"
# )
# db/seeds.rb - Add this to create some activity records
# Create some activities
hub = Hub.first
users = User.all

10.times do |i|
  Activity.create(
    action: Activity::USER_JOINED,
    user: users.sample,
    hub: hub,
    trackable_type: "User",
    trackable_id: 1,
    created_at: i.days.ago,
    data: { name: "Test User #{i}", email: "user#{i}@ooma.com" }
  )
end

challenges = Challenge.all
20.times do |i|
  challenge = challenges.sample
  user = users.sample

  Activity.create(
    action: [Activity::CHALLENGE_COMPLETED, Activity::STORY_SUBMITTED].sample,
    user: user,
    hub: hub,
    trackable: challenge,
    created_at: i.hours.ago,
    data: {
      challenge_title: challenge.title,
      story_title: "My Story #{i}",
      points: challenge.points
    }
  )
end