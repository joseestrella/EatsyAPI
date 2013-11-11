class CreateEstablecimientos < ActiveRecord::Migration
  def change
    create_table :establecimientos do |t|
      t.string :nombre
      t.string :descripcion
      t.string :categoria
      t.float :latitud
      t.float :longitud
      t.string :direccion
      t.float :calificacion
    end
  end
end
