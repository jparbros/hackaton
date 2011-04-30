module Helpers

  def user
    foursquare.user
  end

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/callback'
    uri.query = nil
    uri.to_s
  end

  def client
    @client ||= ::Foursquare2::OAuth2.new('M3Z2OBWQB4RPYNY22S112I4DVI5W4VQB5LRDJRPGEK1LK5RO',
                                          '53BWA4J3YLU4ZEM2NNNAHFQMG0AOAZ3GRO25UBRD5OFAWGLC',
                                          redirect_uri)
  end

  def foursquare
    @foursquare ||= Foursquare2::Base.new(client)
  end

  def logged?
    !!session[:foodfinder]
  end

  def save_geolocation
    session[:foodfinder] ||= {}
    session[:foodfinder][:latitude] = request.cookies['foodfinder-lat']
    session[:foodfinder][:longitude] = request.cookies['foodfinder-lon']
  end

end
