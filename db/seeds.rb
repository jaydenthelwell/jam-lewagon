# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

puts "Cleaning the database"
TopGenre.destroy_all
User.destroy_all
# Match.destroy_all
Swipe.destroy_all
Profile.destroy_all

# User.create(email: "luke@luke.com", password: "123456", name: "Luke", location:"London", description: "I am Luke from London", birth_year: 1990, gender: "male", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")
# User.create(email: "mary@mary.com", password: "123456", name: "Mary", location:"Paris", description: "I am Mary from Paris", birth_year: 1992, gender: "female", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")
# User.create(email: "phil@phil.com", password: "123456", name: "Phil", location:"Manchester", description: "I am Phil from Manchester", birth_year: 1991, gender: "male", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")
# User.create(email: "leah@leah.com", password: "123456", name: "Leah", location:"Rome", description: "I am Leah from Rome", birth_year: 1994, gender: "female", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")

PICTURES = [
  "https://images.unsplash.com/photo-1480429370139-e0132c086e2a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3088&q=80",
  "https://images.unsplash.com/photo-1602233158242-3ba0ac4d2167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3136&q=80",
  "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2662&q=80",
  "https://images.unsplash.com/photo-1628015081036-0747ec8f077a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Z2lybHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1488161628813-04466f872be2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3164&q=80",
  "https://images.unsplash.com/photo-1664575599736-c5197c684128?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2970&q=80"
]

puts "Creating Users ..."

30.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456",
    location: Faker::Address.city,
    description: Faker::Hipster.sentence,
    date_of_birth: Faker::Date.between(from: '1900-09-23', to: '2005-08-28'),
    gender: ["male", "female", "other"].sample,
    on_repeat: Faker::Music::PearlJam.song,
    all_time_favorite: Faker::Music::Prince.song,
    go_to_karaoke: Faker::Music::RockBand.song
  )
  file = URI.open(PICTURES.sample)
  user.photo.attach(io: file, filename: "banana.png", content_type: "image/png")
  user.save!
  puts "Created User: #{user.id}"

  profile = Profile.new(user: user)
  profile.save!
  puts "Created Profile: #{user.id}"
end

puts "Created #{User.count} Users"

@users = User.all

puts "Creating Top Genres"

2.times do
  @users.each do |user|
    top_genre = TopGenre.new(
      genre: Faker::Music.genre,
      user_id: user.id
    )
    top_genre.save!
  end
end

puts "Created #{TopGenre.count} Top Genres"
