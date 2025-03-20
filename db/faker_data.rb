require 'faker'

# Create 10 random singers using Faker
10.times do
  singer = Singer.create!(
    name: Faker::Music.band,  # Random band name as singer
    birthdate: Faker::Date.birthday(min_age: 20, max_age: 60),
    genre: Faker::Music.genre  # Random genre
  )

  # Create 3 random songs for each of the fake singers
  3.times do
    Song.create!(
      title: Faker::Music.album,  # Random album name as song title
      release_date: Faker::Date.backward(days: 1000),  # Random release date within the last 1000 days
      singer: singer  # Associate song with the singer
    )
  end
end

puts "✅ Added random singers and songs using Faker."
