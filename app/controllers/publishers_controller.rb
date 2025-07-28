class PublishersController < ApplicationController
  def index
    @publishers = Publisher.includes(:books).order(:name).page(params[:page]).per(30)
    add_breadcrumb "Publishers", publishers_path
  end

  def show
    @publisher = Publisher.includes(:books).find(params[:id])
    @books = @publisher.books.includes(:author).order(publication_year: :desc).page(params[:page]).per(10)
    
    add_breadcrumb "Publishers", publishers_path
    add_breadcrumb @publisher.name
  end
end