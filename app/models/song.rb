class Song < ActiveRecord::Base
  validates :title, presence: true

  before_create :add_song
  before_destroy :remove_song

private
  def authenticate_client
    @client = Soundcloud.new(:client_id => ENV['Client_ID'],
                        :client_secret => ENV['Secret_Client_ID'],
                        :username => ENV['username'],
                        :password => ENV['password'],
                        :grant_type => 'password',
                        :content_type => 'application/x-www-form-urlencoded',
                        :scope => 'non-expiring')
  end

  def add_song
    authenticate_client
    playlist = @client.get("/me/playlists").first
    track_ids = playlist.tracks.map(&:id)
    track_id = @client.get('/tracks', :q => self.title + " " + self.artist)[0]["id"]
    track_ids << track_id
    self.track_id = track_id
    tracks = track_ids.map{|id| {:id => id}}
    playlist = @client.put(playlist.uri, :playlist => { :tracks => tracks })
    playlist.tracks.map(&:id)
  end

  def remove_song
    authenticate_client
    playlist = @client.get("/me/playlists").first
    track_ids = playlist.tracks.map(&:id)
    track_id = @client.get('/tracks', :q => self.title + " " + self.artist)[0]["id"]
    track_ids.delete(self.track_id)
    tracks = track_ids.map{|id| {:id => id}}
    playlist = @client.put(playlist.uri, :playlist => { :tracks => tracks })
    playlist.tracks.map(&:id)
  end
end
