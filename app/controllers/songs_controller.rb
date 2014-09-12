class SongsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    authorize! :create, @song
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      flash[:notice] = "Song added!"
      redirect_to song_path(@song)
    else
      render 'new'
    end
    authorize! :create, @song
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    authorize! :create, @song
  end

private
  def song_params
    params.require(:song).permit(:title, :artist, :track_id)
  end
end
