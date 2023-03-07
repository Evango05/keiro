json.extract! hotspot, :id, :name, :description, :hotspot_picture, :address, :latitude, :longitude, :created_at, :updated_at
json.url hotspot_url(hotspot, format: :json)
