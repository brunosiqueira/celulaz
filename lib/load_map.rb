#Recupera uma localização a partir de um endereço

module LoadMap
  def get_map(address, id="mapa")
    res=get_location(address)

    map = GMap.new(id)
    map.control_init(:small_map => true,:map_type => true)
    map.center_zoom_init([res.lat,res.lng],14)
    map.overlay_init(GMarker.new([res.lat,res.lng]))
    return map
  end

  def get_location(address)
    GeoKit::Geocoders::GoogleGeocoder.geocode(address.to_s)
  end
end
