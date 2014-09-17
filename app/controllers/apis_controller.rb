class ApisController < ApplicationController
  protect_from_forgery with: :null_session
  before_filter :restrict_access, except: [:index]
  respond_to :json

  def index
    @songs = Song.all
    render json: @songs
  end

  def show
    @song = Song.find(params[:id])
    render json: @song
  end

  def create
    @song = Song.new(song_params)
    if @user.admin
      if @song.save
        render :json => @song, :status => 201
      else
        render :json => @song.errors, :status => 422
      end
    else
      render :json => @song.errors, :status => 401
    end
  end

  def destroy
    @song = Song.find(params[:id])
    if @user.admin
      @song.destroy
      head :no_content
    else
      render :json => @song.errors, :status => 401
    end
  end

private
  def song_params
    params.require(:song).permit(:title, :artist, :track_id)
  end

  def restrict_access
    if request.format.json?
      authenticate_or_request_with_http_token do |token, options|
        @user = User.find_by(token: token)
        User.exists?(token: token)
      end
    end
  end
end
