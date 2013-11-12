class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre_usuario
      t.string :password
      t.string :nombre
      t.date :fecha_nacimiento
      t.string :descripcion_intereses
    end
  end
end
