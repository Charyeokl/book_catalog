class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.includes(:author).order(created_at: :desc)
  end
  def index
    add_breadcrumb "Books", books_path
    @books = Book.includes(:author, :publisher, :genres)
    
    # Apply filters
    @books = @books.where("title ILIKE ?", "%#{params[:q]}%") if params[:q].present?
    @books = @books.joins(:genres).where(genres: { id: params[:genre_id] }) if params[:genre_id].present?
    @books = @books.where("rating >= ?", params[:min_rating].to_f) if params[:min_rating].present?
    
    @books = @books.order(created_at: :desc).page(params[:page]).per(25)
  end
  
  def show
    add_breadcrumb "Books", books_path
    add_breadcrumb @book.title
  end
  
  def search
    query = params[:q].to_s.strip
    @query = query
    
    if query.present?
      # Search books by title, ISBN, or author name
      @books = Book.joins(:author)
                   .where("books.title ILIKE :query OR 
                           books.isbn = :exact OR 
                           authors.name ILIKE :query", 
                           query: "%#{query}%", exact: query)
                   .includes(:author, :publisher)
                   .order(rating: :desc)
                   .page(params[:page]).per(20)
    else
      @books = Book.none
    end
    
    add_breadcrumb "Search: #{@query}"
  end 
  
  private
  
  def set_book
    @book = Book.includes(:author, :publisher, :genres).find(params[:id])
  end
end