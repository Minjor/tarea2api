class CreateIngredientes < ActiveRecord::Migration[5.2]
  def change #ojo con primary key, no queda clara la documentación
    create_table :ingredientes do |t|
      t.string :nombre
      t.string :descripcion
    end
  end
end
