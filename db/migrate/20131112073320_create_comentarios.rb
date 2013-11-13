class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.integer :idEstablecimiento
      t.string :coment
    end
  end
end
