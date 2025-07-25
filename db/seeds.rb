require 'faker'

# Clear existing data
[BookGenre, Book, Genre, Author, Publisher].each(&:destroy_all)

# Create publishers
10.times do
  Publisher.create!(
    name: Faker::Book.unique.publisher,
    location: Faker::Address.country
  )
end

# Create authors
50.times do
  Author.create!(
    name: Faker::Book.unique.author,
    birth_year: rand(1800..1990),
    bio: Faker::Lorem.paragraphs(number: 2).join("\n\n")
  )
end

# Create genres
genres = Faker::Book.genres.uniq.map do |name|
  Genre.find_or_create_by!(name: name)
end

# Create books with associations
200.times do
  book = Book.create!(
    title: Faker::Book.title,
    isbn: Faker::Code.unique.isbn(base: 13),
    publication_year: rand(1900..2023),
    rating: rand(1.0..5.0).round(1),
    page_count: rand(80..800),
    description: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    author: Author.all.sample,
    publisher: Publisher.all.sample
  )
  
  # Assign 1-3 random genres
  book.genres << genres.sample(rand(1..3))
end

puts "Seeded #{Publisher.count} publishers"
puts "Seeded #{Author.count} authors"
puts "Seeded #{Genre.count} genres"
puts "Seeded #{Book.count} books"
puts "Seeded #{BookGenre.count} genre associations"