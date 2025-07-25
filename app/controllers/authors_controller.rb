class AuthorsController < ApplicationController
  def index
    @authors = Author.includes(:books).order(:name).page(params[:page]).per(30)
    add_breadcrumb "Authors", authors_path
  end

  def show
    @author = Author.includes(:books).find(params[:id])
    @books = @author.books.order(publication_year: :desc).page(params[:page]).per(10)
    
    add_breadcrumb "Authors", authors_path
    add_breadcrumb @author.name
  end
end