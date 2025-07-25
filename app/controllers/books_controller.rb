class BooksController < ApplicationController
   before_action :set_book, only: [:show]
  
  def index
    add_breadcrumb "Books", books_path
    # ...
  end
  
  def show
    add_breadcrumb "Books", books_path
    add_breadcrumb @book.title
  end
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
  def index
    @books = Book.includes(:author, :publisher, :genres)
                 .order(created_at: :desc)
                 .page(params[:page]).per(25)
  end

  def index
    @books = Book.includes(:author, :publisher, :genres)
                 .order(rating: :desc)
                 .page(params[:page]).per(20)
  end

  def show
    @book = Book.find(params[:id])
  end
  def show
  @book = Book.includes(:author, :publisher, :genres).find(params[:id])
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
  def index
  @books = Book.includes(:author, :publisher, :genres)
  
  # Apply filters
  @books = @books.where("title ILIKE ?", "%#{params[:q]}%") if params[:q].present?
  @books = @books.joins(:genres).where(genres: { id: params[:genre_id] }) if params[:genre_id].present?
  
  if params[:min_rating].present?
    @books = @books.where("rating >= ?", params[:min_rating].to_f)
  end
  
  @books = @books.order(created_at: :desc).page(params[:page]).per(25)
end