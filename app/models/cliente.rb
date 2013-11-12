class Cliente < ActiveRecord::Base
  attr_accessible :nombre_usuario, :password, :nombre, :fecha_nacimiento, :descripcion_intereses
end
