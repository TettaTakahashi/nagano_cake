class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
end

def genres
    
end

def create
  @genre=Genre.new(genre_params)
  @genre.save
  redirect_to admin_genres_path
end


private

def genre_params
  params.require(:genre).permit(:genre_name)
end