class Establecimiento < ActiveRecord::Base
  attr_accessible :calificacion, :categoria, :descripcion, :direccion, :latitud, :longitud, :nombre
end
