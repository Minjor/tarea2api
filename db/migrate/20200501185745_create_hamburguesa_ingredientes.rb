class CreateHamburguesaIngredientes < ActiveRecord::Migration[5.2]
  def change
    create_table :hamburguesa_ingredientes do |t|
      t.integer :hamburguesa_id
      t.integer :ingrediente_id
    end
  end
end
