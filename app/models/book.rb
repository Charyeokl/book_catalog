class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  has_many :book_genres, dependent: :destroy
  has_many :genres, through: :book_genres
  
  validates :title, :isbn, :publication_year, presence: true
  validates :isbn, uniqueness: true
  validates :rating, numericality: { in: 0.0..5.0 }, allow_nil: true
  validates :publication_year, numericality: { 
    only_integer: true, 
    greater_than: 1800, 
    less_than_or_equal_to: Date.today.year 
  }
   scope :search_by_title_author_isbn, ->(query) {
    joins(:author)
      .where(
        "books.title ILIKE :q OR 
         authors.name ILIKE :q OR 
         books.isbn = :exact",
        q: "%#{query}%", exact: query
      )
      .distinct
  }
end