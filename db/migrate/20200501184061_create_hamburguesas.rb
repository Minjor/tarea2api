class CreateHamburguesas < ActiveRecord::Migration[5.2]
  def change
    create_table :hamburguesas do |t|
      t.string :nombre
      t.integer :precio
      t.string :descripcion
      t.string :imagen
      t.jsonb :ingredientes, default: []
    end
  end
end
