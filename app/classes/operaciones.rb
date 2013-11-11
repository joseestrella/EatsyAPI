class Operaciones
  def self.distancia(lat1,long1,lat2,long2)
    r= 6378.137
    dLat=(lat1-lat2)*Math::PI/180
    dLong=(long1-long2)*Math::PI/180
    a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos((lat2)*Math::PI/180) * Math.cos((lat1)*Math::PI/180) * Math.sin(dLong/2) * Math.sin(dLong/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = r * c * 1000
    return d
  end
end