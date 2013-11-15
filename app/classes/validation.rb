class Validation
  def validateActualizarUsuario(params)
    begin
      json = JSON.parse(params[:actualizar])
    rescue => ex
      return false
    end
    if(json['api-key'] != "eatsy_key123")
      return false
    end
    cliente=Cliente.where(:nombre_usuario => json['nombre_usuario'])
    if cliente.any?
      if (defined?(json['nombre'])==nil || json['nombre'].blank?)
        json['nombre']=cliente.nombre
      end
    end
  end

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
    if(defined?(json['categoria']) == nil)
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
    if(json['descripcion'].blank?)
      return false
    end
    if(json['latitud'].blank?)
      return false
    end
    if(json['longitud'].blank?)
      return false
    end
    if(json['categoria'].blank?)
      return false
    end
    if(json['direccion'].blank?)
      return false
    end
    json2={"nombre" => json['nombre'],"descripcion" => json['descripcion'], "categoria" => json['categoria'], "latitud" => json['latitud'], "longitud" => json['longitud'], "direccion" => json['direccion'], "calificacion" => 0}
    return json2.to_json
  end

  def self.validateCreateCliente(params)
    begin
      json = JSON.parse(params[:crear])
    rescue => ex
      return false
    end
    print "\n +++ llego aca"
    if(json['api-key'] != "eatsy_key123")
      return false
    end
    if(json['nombre_usuario'].blank?)
      return false
    elsif(Cliente.where(:nombre_usuario => json['nombre_usuario']).any?)
      return false #Verifica si no existe algun usuario con el mismo nombre de usuario
    end
    if(json['password'].blank?)
      return false
    end
    if(json['nombre'].blank?)
      return false
    end
    if(json['fecha_nacimiento'].blank?)
      return false
    end
    if(defined?(json['descripcion_intereses']) == nil)
      json['descripcion_intereses']="ALL"
    end

    json2={"nombre_usuario" => json['nombre_usuario'],"password" => json['password'], "nombre" => json['nombre'], "fecha_nacimiento" => json['fecha_nacimiento'], "descripcion_intereses" => json['descripcion_intereses']}
    return json2.to_json
  end

  def self.validateUpdate(params)
    begin
      json = JSON.parse(params[:actualizar])
    rescue => ex
      return false
    end
    if(json['api-key'] != "eatsy_key123")
      return false
    end
    if(json['idestablecimiento'].blank?)
      return false
    end

    if((json['comentario'].blank?)&&(json['calificacion'].blank?))
      return false
    end

    #json2={"nombre" => json['nombre'],"descripcion" => json['descripcion'], "categoria" => json['categoria'], "latitud" => json['latitud'], "longitud" => json['longitud'], "direccion" => json['direccion'], "calificacion" => 0}
    return true
  end


  def self.validateVerUsuario(params)
    begin
      json = JSON.parse(params[:ver])
    rescue => ex
      return false
    end
    if(json['api-key'] != "eatsy_key123")
      return false
    end
    if(json['nombre_usuario'].blank?)
      return false
    end
    return json
  end
end
