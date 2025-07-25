class BooksController < ApplicationController
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

  def search
    query = params[:q]
    @books = if query.present?
               Book.search_by_title_author_isbn(query)
                   .page(params[:page]).per(20)
             else
               Book.none
             end
  end
end