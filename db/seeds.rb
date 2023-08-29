# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)


# User.create(email: "luke@luke.com", password: "123456", name: "Luke", location:"London", description: "I am Luke from London", birth_year: 1990, gender: "male", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")
# User.create(email: "mary@mary.com", password: "123456", name: "Mary", location:"Paris", description: "I am Mary from Paris", birth_year: 1992, gender: "female", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")
# User.create(email: "phil@phil.com", password: "123456", name: "Phil", location:"Manchester", description: "I am Phil from Manchester", birth_year: 1991, gender: "male", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")
# User.create(email: "leah@leah.com", password: "123456", name: "Leah", location:"Rome", description: "I am Leah from Rome", birth_year: 1994, gender: "female", on_repeat: "Don't Stop Me Now", all_time_favorite: "", go_to_karaoke: "")


100.times do
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
  user.save!
end
