class Validation
  def self.validateLista(params)
    begin
      json = JSON.parse(params[:lista])
    rescue => ex
      return false
    end

    if(json['api-key'] != "eatsy_key123")
      return false
    end
    if(json['radio'].blank?)
      return false
    end
    if(json['latitud'].blank?)
      return false
    end
    if(json['longitud'].blank?)
      return false
    end
    if(defined?(json['keyword']) == nil)
      json['keyword']=""
    end
    if(!json['categoria'].blank?)
      json['categoria']="ALL"
    end
    return json
  end
  def self.validateCreate(params)
    begin
      json = JSON.parse(params[:crear])
    rescue => ex
      return false
    end
    if(json['api-key'] != "eatsy_key123")
      return false
    end
    if(json['nombre'].blank?)
      return false
    end
    #json2=[]
    #json2['nombre']=json['nombre']
    if(json['descripcion'].blank?)
      return false
    end
    #json2['descripcion']=json['descripcion']
    if(json['latitud'].blank?)
      return false
    end
    #json2['latitud']=json['latitud']
    if(json['longitud'].blank?)
      return false
    end
    #json2['longitud']=json['longitud']
    if(json['categoria'].blank?)
      return false
    end
    #json2['categoria']=json['categoria']
    if(json['direccion'].blank?)
      return false
    end
    #json2['direccion']=json['direccion']
    json2={"nombre" => json['nombre'],"descripcion" => json['descripcion'], "categoria" => json['categoria'], "latitud" => json['latitud'], "longitud" => json['longitud'], "direccion" => json['direccion']}

    return json2.to_json
  end
end
