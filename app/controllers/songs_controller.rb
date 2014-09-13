class SongsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @songs = Song.all
    track_url = 'https://soundcloud.com/user422643470/sets/jukebox'
    @embed_info = @client.get('/oembed', :url => track_url)
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    respond_to do |format|
      format.html
      format.js
    end
    authorize! :create, @song
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Song added!"
          redirect_to song_path(@song)
        end
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'new' }
      end
    end
    authorize! :create, @song
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
    authorize! :destroy, @song
  end

private
  def song_params
    params.require(:song).permit(:title, :artist, :track_id)
  end
end
