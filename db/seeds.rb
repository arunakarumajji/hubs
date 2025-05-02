# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

challenge = Challenge.create!(
  hub: Faker::Company.name,
  title: Faker::Company.catch_phrase,
  description: Faker::Lorem.paragraph,
  sharing_link: Faker::Internet.url,
  points: 100
  )

challenge.image.attach(
  io: URI.open(Faker::Company.logo),
  filename: Faker::Company.name+".jpg",
  content_type: "image/jpg"
)