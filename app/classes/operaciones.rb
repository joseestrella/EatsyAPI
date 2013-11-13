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

  def self.paredes(lat1,long1,radio)
    dLatMetros= 6378.137*(lat1)*Math::PI/180
    dLongMetros=6378.137*(long1)*Math::PI/180
    radio=radio/1000
    izq=dLongMetros-radio
    der=dLongMetros+radio
    abajo=dLatMetros-radio
    arriba=dLatMetros+radio

    izq=(izq*180)/(6378.137*Math::PI)
    der=(der*180)/(6378.137*Math::PI)
    abajo=(abajo*180)/(6378.137*Math::PI)
    arriba=(arriba*180)/(6378.137*Math::PI)
    #puts izq.to_s
    #puts der.to_s
    ##puts abajo.to_s
    #puts arriba.to_s
    return [izq, der, abajo, arriba]
  end
end