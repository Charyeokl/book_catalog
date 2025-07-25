class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  
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
    query = params[:q]
    @books = if query.present?
               Book.search_by_title_author_isbn(query)
                   .page(params[:page]).per(20)
             else
               Book.none
             end
  end 
  
  private
  
  def set_book
    @book = Book.includes(:author, :publisher, :genres).find(params[:id])
  end
end