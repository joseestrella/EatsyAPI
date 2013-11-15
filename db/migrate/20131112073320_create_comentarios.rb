class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.integer :idestablecimiento
      t.string :coment
    end
  end
end
