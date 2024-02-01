class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  
  def index
    @genres = Genre.all
  end
  
  def create
    @genre=Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres=Genre.all
      redirect_to admin_genres_path
    end
  end
  
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end

end