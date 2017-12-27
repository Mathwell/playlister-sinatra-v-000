require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

  get '/songs/new' do
    #binding.pry
    @artists=Artist.all
    @genres=Genre.all
    erb  :'/songs/new'
  end

  get '/songs' do
    @songs=Song.all
    erb :'/songs/index'
  end

  get '/songs/:slug' do
    @song=Song.find_by_slug(params[:slug])
    @genres=@song.genres
    #puts params[:slug]
    #puts @song.genres
    #binding.pry
    erb :'/songs/show'
  end



  post '/songs' do
    #binding.pry
    puts params
    @song=Song.create(:name => params["Name"])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully created song."

    #binding.pry
    #puts @song.slug
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song=Song.find_by_slug(params[:slug])
    erb :edit
  end

  patch '/songs/:slug' do
    @song=Song.find_by_slug(params[:slug])
    @song.update = params[:song]
    #@song.genre_ids = params[:genres]
    @song.save

    redirect to "/songs/#{@song.slug}"
  end



end
