module Helpers

  REDIRECT_URI = '/auth/callback'

  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = REDIRECT_URI
    uri.query = nil
    uri.to_s
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
