class ReportsController < ApplicationController
  def top_books
    @books = Book.order(rating: :desc).limit(25)
  end

  def yearly_stats
    @stats = Book.group_by_year(:publication_year)
                 .count
  end
end