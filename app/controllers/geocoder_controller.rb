class GeocoderController < ApplicationController

  def city_from_location
    latitude = params[:latitude]
    longitude = params[:longitude]
    api_key = Rails.application.credentials.geocoder[:key]
    url = "https://api.opencagedata.com/geocode/v1/json?q=#{latitude}+#{longitude}&key=#{api_key}"

    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)

    if data['results'] && data['results'].any?
      city = data['results'][0]['components']['city'] ||
             data['results'][0]['components']['town'] ||
             data['results'][0]['components']['village']
      render json: { city: city || 'City not found' }
    else
      render json: { error: 'City not found' }, status: :not_found
    end
  rescue StandardError => e
    logger.error "Error fetching city data: #{e.message}"
    render json: { error: 'Unable to retrieve city' }, status: :internal_server_error
  end
end
