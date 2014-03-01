class SoundsController < ApplicationController
  include SoundcloudHelper

  def index
    @client = current_client
    @app_client = Sound::APP_CLIENT
    @sc_user = current_client.get('/me')
    @sounds = @sc_user.tracks
    @user_sounds = @client.get("/users/#{@sc_user.id}/tracks")
  end

  def search
    @client = Sound::APP_CLIENT
    @app_client = Sound::APP_CLIENT
    @sc_user = current_client.get('/me')
    @sounds = @sc_user.tracks
    @user_sounds = @client.get("/users/#{@sc_user.id}/tracks")
    @results = Sound.search(params[:search])
    render :index
  end

  def connected
    sound_profile = Sound.create_sound_profile(params[:code])
    session[:sc_id] = sound_profile.id
    redirect_to sounds_path
  end

  def create
    redirect_to sounds_path
    track = current_client.post('/tracks', track: {:title => params[:track_title], :asset_data => File.new(params[:sound], "rb") } )
  end

  def play
    print params[:track_url]
    @track_url = params[:track_url]
    render :play, :layout => false
  end
end


=begin

client_id = f68ac3f43496b07c21d70f3c9fe7d2c1
client_secret = a027e63e31f728b22cf506620c19c817
=end