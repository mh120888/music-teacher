module SoundcloudHelper
  def current_client
    session[:sc_id] ? Sound.find(session[:sc_id]).client : Sound::APP_CLIENT
  end
end