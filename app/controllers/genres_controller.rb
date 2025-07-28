class GenresController < ApplicationController
  def index
    @genres = Genre.includes(:books).order(:name).page(params[:page]).per(30)
    add_breadcrumb "Genres", genres_path
  end

  def show
    @genre = Genre.includes(:books).find(params[:id])
    @books = @genre.books.includes(:author, :publisher).order(rating: :desc).page(params[:page]).per(10)
    
    add_breadcrumb "Genres", genres_path
    add_breadcrumb @genre.name
  end
end