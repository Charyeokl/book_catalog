class ReportsController < ApplicationController
  def top_books
    @books = Book.order(rating: :desc).limit(25)
    add_breadcrumb "Reports", "#"
    add_breadcrumb "Top Rated Books"
  end

  def yearly_stats
    @stats = Book.group_by_year(:publication_year)
                 .count
  add_breadcrumb "Reports", "#"
  add_breadcrumb "Publication Trends"
  end
end