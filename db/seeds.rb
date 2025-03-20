require 'csv'

# Delete existing data in the correct order (dependent records first)
Song.destroy_all
Album.destroy_all
Singer.destroy_all
Genre.destroy_all

# Import genres from CSV
genres_csv = Rails.root.join('db/genres.csv')
CSV.foreach(genres_csv, headers: true) do |row|
  Genre.find_or_create_by!(name: row['name'])
end
puts "✅ Imported genres from CSV."

# Import singers from CSV
singers_csv = Rails.root.join('db/singers.csv')
CSV.foreach(singers_csv, headers: true) do |row|
  # Find the genre by name
  genre = Genre.find_by(name: row['genre'])
  Singer.find_or_create_by!(name: row['name']) do |singer|
    singer.birthdate = row['birthdate']
    singer.genre = genre
  end
end
puts "✅ Imported singers from CSV."

# Import albums from CSV
albums_csv = Rails.root.join('db/albums.csv')
CSV.foreach(albums_csv, headers: true) do |row|
  Album.find_or_create_by!(title: row['title']) do |album|
    album.release_date = row['release_date']
    album.genre = row['genre']  # In the albums table, genre is a string.
  end
end
puts "✅ Imported albums from CSV."

# Import songs from CSV
songs_csv = Rails.root.join('db/songs.csv')
CSV.foreach(songs_csv, headers: true) do |row|
  singer = Singer.find_by(name: row['singer_name'])
  album  = Album.find_by(title: row['album'])
  genre  = Genre.find_by(name: row['genre'])
  if singer && album && genre
    Song.create!(
      title: row['title'],
      release_date: row['release_date'],
      singer: singer,
      album: album,
      genre: genre
    )
  else
    puts "Could not find singer/album/genre for song: #{row['title']}"
  end
end
puts "✅ Imported songs from CSV."

# Now load the faker data (if you have additional fake data to add)
load Rails.root.join('db/faker_data.rb')

# Print out counts for verification
puts "✅ Total genres: #{Genre.count}"
puts "✅ Total singers: #{Singer.count}"
puts "✅ Total albums: #{Album.count}"
puts "✅ Total songs: #{Song.count}"
