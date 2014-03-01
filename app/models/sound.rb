class Sound < ActiveRecord::Base
  attr_accessible :access_token

  APP_CLIENT = Soundcloud.new({:client_id => ENV['SC_CLIENT_ID'], :client_secret => ENV['SC_CLIENT_SECRET'], :redirect_uri => "http://localhost:3000/sounds/connected"})

  def client
    Soundcloud.new(:access_token => self.access_token )
  end

  def self.embed_html(track_url)
    embed_info = self::APP_CLIENT.get('/oembed', :url => track_url, :maxwidth => "500px", :maxheight => "150px")
    embed_info['html']
  end

  def self.search(params)
    search_terms = compact_search_params(params)
    self::APP_CLIENT.get('/tracks', search_terms, :limit => 5)[0..4]
  end

  def self.compact_search_params(params)
    params.select {|term, value| value != "" }
  end

  def self.create_sound_profile(code)
    access_token_info = Sound::APP_CLIENT.exchange_token(:code => code)
    access_token = access_token_info.response.parsed_response["access_token"]
    Sound.create(access_token: access_token)
  end

  def self.set_client_by_user(user)
    access_token = Sound.where(user_id: user.id).access_token
    Soundcloud.new(:access_token => self.access_token)
  end
end