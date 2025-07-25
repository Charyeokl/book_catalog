require 'net/http'
require 'json'

namespace :import do
  desc "Import books from Google Books API"
  task google_books: :environment do
    query = "ruby+programming"
    url = URI("https://www.googleapis.com/books/v1/volumes?q=#{query}&maxResults=40")
    
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    
    data["items"].each do |item|
      book_info = item["volumeInfo"]
      next unless book_info["industryIdentifiers"] && book_info["authors"]
      
      # Find or create author
      author = Author.find_or_create_by!(name: book_info["authors"].first)
      
      # Find or create publisher
      publisher_name = book_info["publisher"] || "Unknown Publisher"
      publisher = Publisher.find_or_create_by!(name: publisher_name)
      
      # Create book
      book = Book.create!(
        title: book_info["title"],
        isbn: book_info["industryIdentifiers"].find { |id| id["type"] == "ISBN_13" }&.dig("identifier") || SecureRandom.alphanumeric(13),
        publication_year: book_info["publishedDate"][0..3].to_i,
        page_count: book_info["pageCount"],
        description: book_info["description"],
        rating: rand(3.0..5.0).round(1), # API doesn't provide ratings
        author: author,
        publisher: publisher
      )
      
      # Add genres/categories
      if book_info["categories"]
        book_info["categories"].flat_map { |c| c.split("/") }.uniq.each do |cat|
          genre = Genre.find_or_create_by!(name: cat.strip.titleize)
          book.genres << genre unless book.genres.include?(genre)
        end
      end
    end
    
    puts "Imported #{data['items'].size} books from Google Books API"
  end
end